function ellipse = FitPointsToEllipses(points, plotme)
%FitPointsToEllipses  Least-squares fit of ellipse to 2D points.
%   Explanation Direct Least Squares Fitting of Ellipses, IEEE T-PAMI, 1999
%
% inputs
%   points  the polar coordinates of the points, i.e. [x, y].
%   plotme  if passed as true, it plots the points and ellipse.
%
% outputs
%   ellipse  the parameters of the ellipse, [cx, cy, ax, ay, rx].
%
% original code by "Andrew Fitzgibbon, Maurizio Pilu, Bob Fisher"
%

if nargin < 2
  plotme = false;
end

px = points(:, 1);
py = points(:, 2);

% normalize data
mx = mean(px);
my = mean(py);
sx = (max(px) - min(px)) / 2;
sy = (max(py) - min(py)) / 2;

x = (px - mx) / sx;
y = (py - my) / sy;

% Force to column vectors
x = x(:);
y = y(:);

% Build design matrix
D = [x .* x,  x .* y,  y .* y,  x, y, ones(size(x))];

% Build scatter matrix
S = D' * D;

% Build 6x6 constraint matrix
C(6, 6) = 0;
C(1, 3) = -2;
C(2, 2) = 1;
C(3, 1) = -2;

% New way, numerically stabler in C [gevec, geval] = eig(S,C);

% Break into blocks
tmpA = S(1:3, 1:3);
tmpB = S(1:3, 4:6);
tmpC = S(4:6, 4:6);
tmpD = C(1:3, 1:3);
tmpE = tmpC \ tmpB';
[evec_x, eval_x] = eig(tmpD \ (tmpA - tmpB * tmpE));

% Find the positive (as det(tmpD) < 0) eigenvalue
I = real(diag(eval_x)) < 1e-8 & ~isinf(diag(eval_x));

% Extract eigenvector corresponding to negative eigenvalue
A = real(evec_x(:, I));

% Recover the bottom half...
evec_y = -tmpE * A;
A = [A; evec_y];

% unnormalize
sx2 = sx * sx;
sy2 = sy * sy;
sxy = sx * sy;
par = ...
  [
  A(1) * sy2, ...
  A(2) * sxy, ...
  A(3) * sx2, ...
  -2 * A(1) * sy2 * mx - A(2) * sxy * my + A(4) * sx * sy2, ...
  -A(2) * sxy * mx - 2 * A(3) * sx2 * my + A(5) * sx2 * sy, ...
  A(1) * sy2 * mx * mx + A(2) * sxy * mx * my + A(3) * sx2 * my * my - A(4) * sx * sy2 * mx - A(5) * sx2 * sy * my + A(6) * sx2 * sy2
  ]';

% Convert to geometric radii, and centers

rx = 0.5 * atan2(par(2), par(1) - par(3));
cost = cos(rx);
sint = sin(rx);
sin2 = sint .* sint;
cos2 = cost .* cost;
CosSin = sint .* cost;

Ao =  par(6);
Au =  par(4) .* cost + par(5) .* sint;
Av = -par(4) .* sint + par(5) .* cost;
Auu = par(1) .* cos2 + par(3) .* sin2 + par(2) .* CosSin;
Avv = par(1) .* sin2 + par(3) .* cos2 - par(2) .* CosSin;

tuCentre = -Au ./ (2 .* Auu);
tvCentre = -Av ./ (2 .* Avv);
wCentre = Ao - Auu .* tuCentre .* tuCentre - Avv .* tvCentre .* tvCentre;

cx = tuCentre .* cost - tvCentre .* sint;
cy = tuCentre .* sint + tvCentre .* cost;

ax = -wCentre ./ Auu;
ay = -wCentre ./ Avv;

ax = sqrt(abs(ax)) .* sign(ax);
ay = sqrt(abs(ay)) .* sign(ay);

ellipse = [cx, cy, ax, ay, rx];

if plotme
  figure;
  hold on;
  grid on;
  DrawEllipse(ellipse);
  plot(px, py, '*r');
end

end
