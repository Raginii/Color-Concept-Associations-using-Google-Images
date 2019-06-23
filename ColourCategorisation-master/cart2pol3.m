function polarnum = cart2pol3(cartesiannum)
%cart2pol3 transform Cartesian to polar coordinates with positive r.
%   [TH,R] = cart2pol3(X,Y) transforms corresponding elements of data
%   stored in Cartesian coordinates X,Y to polar coordinates (angle TH and
%   radius R). The arrays X and Y must be the same size (or either can be
%   scalar). TH is returned in radians.
%
%   [TH,R,Z] = cart2pol3(X,Y,Z) transforms corresponding elements of data
%   stored in Cartesian coordinates X,Y,Z to cylindrical coordinates
%   (angle TH, radius R, and height Z). The arrays X,Y, and Z must be the
%   same size (or any of them can be scalar).  TH is returned in radians.
%
%   Class support for inputs X,Y,Z:
%      float: double, single
%
%   See also CART2SPH, SPH2CART, POL2CART.
%

x = cartesiannum(:, 1);
y = cartesiannum(:, 2);

th = atan2(y, x);

% converting negative angles to positive
th = (th < 0) .* (th + 2 .* pi()) + (th >= 0) .* th;

r = hypot(x, y);
if size(cartesiannum, 2) == 3
  polarnum= [th, r, cartesiannum(:, 3)];
else
  polarnum= [th, r];
end

end
