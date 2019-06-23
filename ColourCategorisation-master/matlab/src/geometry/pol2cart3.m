function cartesiannum = pol2cart3(polarnum, zfirst)
%pol2cart3 Transform polar to Cartesian coordinates.
%   [X,Y] = pol2cart3(TH,R) transforms corresponding elements of data
%   stored in polar coordinates (angle TH, radius R) to Cartesian
%   coordinates X,Y.  The arrays TH and R must the same size (or
%   either can be scalar).  TH must be in radians.
%
%   [X,Y,Z] = pol2cart3(TH,R,Z) transforms corresponding elements of
%   data stored in cylindrical coordinates (angle TH, radius R, height
%   Z) to Cartesian coordinates X,Y,Z. The arrays TH, R, and Z must be
%   the same size (or any of them can be scalar).  TH must be in radians.
%
%   Class support for inputs TH,R,Z:
%      float: double, single
%
%   See also CART2SPH, CART2POL, SPH2CART.
%

if nargin < 2
  zfirst = 0;
end
th = polarnum(:, 1);
r = polarnum(:, 2);

x = r .* cos(th);
y = r .* sin(th);
if size(polarnum, 2) == 3
  if zfirst
    cartesiannum = [polarnum(:, 3), x, y];
  else
    cartesiannum = [x, y, polarnum(:, 3)];
  end
else
  cartesiannum = [x, y];
end

end
