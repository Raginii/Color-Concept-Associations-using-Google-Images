function Lab_colour = XYZ2Lab(XYZ_colour,Whiteref_XYZcolour)
% XYZ2LAB computes the lightness, L*, and chromatic coordinates a* and b* in
% CIELAB from the tristimulus values of a set of colours.
%
% CIELAB is a simple appearance model providing perceptual descriptors (lightness, hue
% and chroma) for related colours (colours in a scene).
%
% In this representation, information about the illumination conditions or, alternatively,
% about the scene, is included in a reference stimulus. Using CIELAB in the standard
% conditions implies that the reference stilulus is a perfect difuser illuminated as the
% test.
%
% SYNTAX
% ----------------------------------------------------------------------------
% Lab_colour = XYZ2Lab(XYZ_colour,Whiteref_XYZcolour)
%
% Lab_colour  = For N colours, Nx3 matrix, containing, in columns, the lightness L*,
%        and the chromaticity coordinates a* and b*.
%
% Whiteref_XYZcolour = Tristimulus values of the reference stimulus.
%        If the reference stimulus is the same for all the test stimuli, this
%        is a 1x3 matrix. If the reference is different for each tes stimulus
%        XYZR is a Nx3 matrix.
%
% XYZ_colour = Tristimulus values of the test stimuli.
%       For N colours, this is a Nx3 matrix.
%
% ----------------------------------------------------------------------------
% equations were taken from http://en.wikipedia.org/wiki/CIELAB

%===============================================
if nargin < 2
  Whiteref_XYZcolour = [0.9504, 1.0000, 1.0889] .* 100; %D65 times 100Cd/m^2 -monitor max luminance
end

[lin, col, pla] = size(XYZ_colour);
if pla ==3
  XYZ_colour = reshape(XYZ_colour,lin*col,pla);
  Whiteref_XYZcolour = repmat(Whiteref_XYZcolour(1,:),lin*col,1);
  Lab_colour = zeros(lin*col,3);
else
  Whiteref_XYZcolour=repmat(Whiteref_XYZcolour,lin,1);
  Lab_colour = zeros(lin,3);
end

delta = 6/29;

fX = ((XYZ_colour(:,1)./Whiteref_XYZcolour(:,1)) >  (delta.^3)).* (XYZ_colour(:,1)./Whiteref_XYZcolour(:,1)).^(1/3) +...
  ((XYZ_colour(:,1)./Whiteref_XYZcolour(:,1)) <= (delta.^3)).* ((1/3 .* (1/delta).^2) .* (XYZ_colour(:,1)./Whiteref_XYZcolour(:,1)) + 4/29);

fY = ((XYZ_colour(:,2)./Whiteref_XYZcolour(:,2)) >  (delta.^3)).* (XYZ_colour(:,2)./Whiteref_XYZcolour(:,2)).^(1/3) +...
  ((XYZ_colour(:,2)./Whiteref_XYZcolour(:,2)) <= (delta.^3)).* ((1/3 .* (1/delta).^2) .* (XYZ_colour(:,2)./Whiteref_XYZcolour(:,2)) + 4/29);

fZ = ((XYZ_colour(:,3)./Whiteref_XYZcolour(:,3)) >  (delta.^3)).* (XYZ_colour(:,3)./Whiteref_XYZcolour(:,3)).^(1/3) +...
  ((XYZ_colour(:,3)./Whiteref_XYZcolour(:,3)) <= (delta.^3)).* ((1/3 .* (1/delta).^2) .* (XYZ_colour(:,3)./Whiteref_XYZcolour(:,3)) + 4/29);


Lab_colour(:,1) = 116 .* fY - 16; % L

Lab_colour(:,2) = 500 .* (fX - fY); % a

Lab_colour(:,3) = 200 .* (fY - fZ); % b

if pla ==3
  Lab_colour = reshape(Lab_colour, lin, col, pla);
end

end
