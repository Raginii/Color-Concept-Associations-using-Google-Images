function out = colorconvert( color, colorspace, ref, varargin )
%COLORCONVERT convert color coordinates between different color spaces.
% out = COLORCONVERT( color, colorspace, ref ) takes colors specified in
% the  color space "colorspace". Valid options for "colorspace" are:
%   'XYZ': CIE 1931 XYZ color space (X,Y,Z)
%   'xyY': CIE 1931 xyY color space (x,y,Y)
%   'Lab': CIE 1976 L*a*b* color space (L,a,b)
%   'Luv': CIE 1976 L*u*v* (CIELUV) color space (L,u,v)
% 'LChab': cylindrical representation of CIELAB space with the hue angle
%          hab specified in degrees (L,Cab,hab).
% 'LChuv': cylindrical representation of CIELUV space with the hue angle
%          huv specified in degrees (L,Cuv,huv).
%    'CC': cone-opponent contrast space as specified in Eskew, McLellan,
%          and Giulianini (1999). (LMc,Sc,Lumc).
% The "color" input is a N x 3 matrix where each row is a color to be
% converted and each column is a coordinate in the chosen color space.
% Columns must be ordered as in the colorspace specification above.
% The refererence point "ref" (whitepoint reference) can be one of
% 'D65': Illuminant D65 (white)
%  'C' : Illuminant C
% The whitepoint reference is used for converting to Lab, Luv, LChab, LChuv
% from XYZ coordinates and vice versa.
%
% out = COLORCONVERT( color, colorspace, ref, refspace ) is used to specify
% a custom whitepoint reference. In this case, "ref" is a vector of length
% 3 and "refspace" is one of 'xyY' or 'XYZ'.
%
% The output "out" is a struct that contains the conversions of the input
% colors into all the color spaces specified above. For example, to convert
% c = [0.25, 0.35, 70] from xyY to Lab coordinates using a D65 whitepoint,
% we would write the following code:
%     out = colorconvert(c,'xyY','D65');
%     L = out.L
%     a = out.a
%     b = out.b
% The fields contained in "out" are the standard coordinates listed above:
% {X,Y,Z,x,y,L,a,b,u,v,Cab,Cuv,hab,huv,LMc,Sc,Lumc}
% Also included are the saturation in Lab and Luv coordinates {Sab,Suv}
% and the whitepoint in XYZ coordinates {Xn,Yn,Zn}
% 
% written by Laurent Lessard, version 1.1, 8/27/2018.
% www.laurentlessard.com


% structure that will hold all the converted coordinates
out = struct;

%% compute XYZ coordinates of the reference
if ~isnumeric(ref)
    try
        switch ref
            case 'D65'  % Standard illuminant D65 (white)
                Xn = 95.047;
                Yn = 100.000;
                Zn = 108.883;
            case 'C'    % Illuminant C
                xc = 0.31006;
                yc = 0.31616;
                Yc = 100.000;
                [Xn,Yn,Zn] = xyY_XYZ( [xc yc Yc] );
            otherwise
                error('built-in whitepoints include ''D65'' and ''C''.')
        end
    catch
        error('invalid whitepoint specification')
    end
else
    if nargin == 4
        switch varargin{1}
            case 'XYZ'
                Xn = ref(1);
                Yn = ref(2);
                Zn = ref(3);
            case 'xyY'
                [Xn,Yn,Zn] = xyY_XYZ( ref );
            otherwise
                error('reference must be specified in ''XYZ'' or ''xyY'' color space')
        end
        if numel(ref) ~= 3
            error('invalid custom whitepoint (should have 3 coordinates)')
        end
    else
        error('must specify the color space for the custom whitepoint reference (XYZ or xyY)')
    end
end


%% Note for converting to/from Cone Contrast Space:
% If it is desired to use a different reference point in converting to/from
% cone-opponent contrast space (e.g., the background color instead of
% white), change the lines below to the new reference in XYZ coordinates. 
% By default, the cone contrast reference point is the same as the
% whitepoint for all other color spaces.
Xncc = Xn;
Yncc = Yn;
Zncc = Zn;

%% error checking on first input (color coordinates)
if ~isnumeric(color)
    error('color coordinates must be in numerical array format')
else
    sz = size(color);
    if numel(sz) ~= 2
        error('color should be an Nx3 array')
    else
        if sz(2) ~= 3
            error('color should have 3 columns')
        end
    end
end

%% apply a conversion to CIEXYZ depending on which space was used
try
    switch colorspace
        case 'XYZ'
            X = color(:,1); Y = color(:,2); Z = color(:,3);
        case 'xyY'
            [X, Y, Z] = xyY_XYZ( color );
        case 'Lab'
            [X, Y, Z] = Lab_XYZ( color );
        case 'Luv'
            [X, Y, Z] = Luv_XYZ( color );
        case 'Lchuv'
            [X, Y, Z] = LChuv_XYZ( color );
        case 'Lchab'
            [X, Y, Z] = LChab_XYZ( color );
        case 'CC'
            [X, Y, Z] = CC_XYZ( color );
        otherwise
            error('invalid color space; valid choices are ''XYZ'', ''xyY'', ''Lab'', ''Luv'', ''LChab'', ''LChuv''')
    end
catch
    error('invalid colorspace specification')
end

%% convert to every color space

% include CIE XYZ coordinates and reference
out.X  = X;      out.Y  = Y;      out.Z  = Z;
out.Xn = Xn;     out.Yn = Yn;     out.Zn = Zn;

% include CIE 1931 xyY (the Y is the same as in CIEXYZ)
[out.x, out.y, ~] = XYZ_xyY(X,Y,Z);

% convert to CIE 1976 L*a*b*
[out.L, out.a, out.b, out.Sab, out.Cab, out.hab] = XYZ_Lab(X,Y,Z);

% convert to CIE 1976 L*u*v* (the L* is the same as in CIELAB)
[~, out.u, out.v, out.Suv, out.Cuv, out.huv] = XYZ_Luv(X,Y,Z);

% convert to Cone-Opponent Contrast
[out.LMc, out.Sc, out.Lumc] = XYZ_CC(X,Y,Z);


%% HELPER FUNCTIONS: converting (anything) --> (XYZ)

    % convert from xyY
    function [X,Y,Z] = xyY_XYZ( color )
        x = color(:,1); y = color(:,2); Y = color(:,3);
        X = (Y./y) .* x;
        Z = (Y./y) .* (1-x-y);
    end

    % convert from Lab
    function [X,Y,Z] = Lab_XYZ( color )
        L = color(:,1); a = color(:,2); b = color(:,3);
        X = Xn * finv( (L+16)/116 + a/500 );
        Y = Yn * finv( (L+16)/116 );
        Z = Zn * finv( (L+16)/116 - b/200 );
    end

    % convert from Luv
    function [X,Y,Z] = Luv_XYZ( color )
        L = color(:,1); u = color(:,2); v = color(:,3);
        unPrime = 4*Xn./(Xn + 15*Yn + 3*Zn);
        vnPrime = 9*Yn./(Xn + 15*Yn + 3*Zn);
        uPrime = u./(13*L) + unPrime;
        vPrime = v./(13*L) + vnPrime;
        Y = Yn * finv( (L+16)/116 );
        X = Y .* (9*uPrime) ./ (4*vPrime);
        Z = Y .* (12 - 3*uPrime - 20*vPrime) ./ (4*vPrime);
    end

    % convert from LChuv
    function [X,Y,Z] = LChuv_XYZ( color )
        L = color(:,1); Cuv = color(:,2); huv = color(:,3);
        u = Cuv .* cosd( huv );
        v = Cuv .* sind( huv );
        [X,Y,Z] = Luv_XYZ( [L u v] );
    end

    % convert from LChab
    function [X,Y,Z] = LChab_XYZ( color )
        L = color(:,1); Cab = color(:,2); hab = color(:,3);
        a = Cab .* cosd( hab );
        b = Cab .* sind( hab );
        [X,Y,Z] = Lab_XYZ( [L a b] );
    end

    % convert from CC
    function [X,Y,Z] = CC_XYZ( color )
        LMc = color(:,1); Sc = color(:,2); Lumc = color(:,3);
        
        tmp = [.7 -.72 .02; -.55 -.25 .8; .9 .43 0 ]\[LMc';Sc';Lumc'];
        DeltaL = tmp(1,:)';
        DeltaM = tmp(2,:)';
        DeltaS = tmp(3,:)';
        
        L_b =  0.15514*Xncc + 0.54312*Yncc - 0.03286*Zncc;
        M_b = -0.15514*Xncc + 0.45684*Yncc + 0.03286*Zncc;
        S_b =                                0.01608*Zncc;

        L_s = L_b*DeltaL + L_b;
        M_s = M_b*DeltaM + M_b;
        S_s = S_b*DeltaS + S_b;
        
        tmp = [ 0.15514 0.54312 -0.03286;-0.15514 0.45684 0.03286;0 0 0.01608]\[L_s';M_s';S_s']; 
        X = tmp(1,:)';
        Y = tmp(2,:)';
        Z = tmp(3,:)';
    end

    function v = finv(vv)
        % inverts the f function (see end of file). Derived analytically
        v = zeros(size(vv));
        ixs = find( vv < 6/29 );        % the small numbers
        ixb = find( vv >= 6/29 );       % the big numbers
        v(ixs) = (108/841)*(vv(ixs) - 16/116);
        v(ixb) = vv(ixb).^3;
    end
        
%% HELPER FUNCTIONS: converting (XYZ) --> (anything)

    % convert to xyY
    function [x,y,Y] = XYZ_xyY(X,Y,Z)
        x = X./(X+Y+Z);
        y = Y./(X+Y+Z);
    end

    % convert to CIELAB (include cylindrical representation also)
    function [L,a,b,Sab,Cab,hab] = XYZ_Lab(X,Y,Z)
        Xcor = f(X/Xn);
        Ycor = f(Y/Yn);
        Zcor = f(Z/Zn);
        L = ( 116 * Ycor ) - 16;
        a = 500 * ( Xcor - Ycor );
        b = 200 * ( Ycor - Zcor );
        % calculate cylindrical coordinates
        Cab = (a.^2 + b.^2).^(1/2);
        Sab = Cab ./ L;
        hab = mod(atan2d(b,a),360);
    end

    % convert to CIELUV (include cylindrical representation also)
    function [L,u,v,Suv,Cuv,huv] = XYZ_Luv(X,Y,Z)
        uPrime  = 4*X ./(X  + 15*Y  + 3*Z );
        vPrime  = 9*Y ./(X  + 15*Y  + 3*Z );
        unPrime = 4*Xn./(Xn + 15*Yn + 3*Zn);
        vnPrime = 9*Yn./(Xn + 15*Yn + 3*Zn);
        L = 116*f(Y/Yn) - 16;   % same as the L in CIELAB.
        u = 13*L.*(uPrime - unPrime);
        v = 13*L.*(vPrime - vnPrime);
        % compute cylindrical coordinates
        Suv = 13*((uPrime - unPrime).^2 + (vPrime - vnPrime).^2).^(1/2);
        Cuv = Suv .* L;
        huv = mod(atan2d(v,u),360);
    end

    % convert to Cone-Opponent Contrast
    function [LMc, Sc, Lumc] = XYZ_CC(X,Y,Z)
        L_s =  0.15514*X  + 0.54312*Y  - 0.03286*Z;
        M_s = -0.15514*X  + 0.45684*Y  + 0.03286*Z;
        S_s =                            0.01608*Z;
        L_b =  0.15514*Xncc + 0.54312*Yncc - 0.03286*Zncc;
        M_b = -0.15514*Xncc + 0.45684*Yncc + 0.03286*Zncc;
        S_b =                                0.01608*Zncc;
        DeltaL = (L_s-L_b)/L_b;
        DeltaM = (M_s-M_b)/M_b;
        DeltaS = (S_s-S_b)/S_b;
        LMc  =   .7*DeltaL - .72*DeltaM + .02*DeltaS;
        Sc   = -.55*DeltaL - .25*DeltaM +  .8*DeltaS;
        Lumc =   .9*DeltaL + .43*DeltaM;
    end

    function vv = f(v)
    % this fixes dark colors (Ohta & Roberston, p. 141 eqs. 4.14-4.15)
    % also the same formula in (Wyszecki & Stiles, p. 167)
        vv = zeros(size(v));
        ixs = find( v < (6/29)^3 );     % the small numbers
        ixb = find( v >= (6/29)^3 );    % the big numbers
        vv(ixs) = (841/108)*v(ixs) + 16/116;
        vv(ixb) = v(ixb).^(1/3);
    end
    
end
