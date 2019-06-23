function slices = FitPointsToSlices(points, centre, plotme)
%FitPointsToSlices  fits a set of points two a slice (two lines).
%
% inputs
%   points  the polar coordinates of the points.
%   centre  the polar coordinates of the centre, default [0, 0].
%   plotme  if true the points and the slice is plotted.
%
% outputs
%   slices  struct containgin two angles and error.
%

if nargin < 3
  plotme = false;
end
if nargin < 2
  centre = [0, 0];
end

slices = OptimiseSlice(points(:, 1:2), centre, plotme);

end

function slice = OptimiseSlice(CartPoints, centre, plotme)

if nargin < 3
  plotme = false;
end

CartPoints(:, 1) = CartPoints(:, 1) - centre(1);
CartPoints(:, 2) = CartPoints(:, 2) - centre(2);

[thetas, ~] = cart2pol(CartPoints(:, 1), CartPoints(:, 2));
thetas(thetas < 0) = thetas(thetas < 0) + (2 * pi);

[th1, ind1] = min(thetas);
[th2, ind2] = max(thetas);
midth = (th1 + th2) / 2;

options = optimoptions(@fmincon,'Algorithm', 'interior-point', 'Display', 'off', 'MaxIter', 1e6, 'TolFun', 1e-10, 'MaxFunEvals', 1e6, 'InitBarrierParam', 1e10, 'TolX', 1e-2);
initial = [th1, th2];
lb = [min(th1, midth), min(th2, midth)];
ub = [max(th1, midth), max(th2, midth)];
[angles, rss, ~, ~] = fmincon(@(x) SliceFitting(x, CartPoints), initial, [], [], [], [], lb, ub, [], options);

slice = struct();
slice.angle1 = angles(1);
slice.angle2 = angles(2);
slice.error = rss;

if plotme
  figure;
  hold on;
  grid on;
  plot(CartPoints(:, 1), CartPoints(:, 2), '*');
  s = [0, 0];
  [x1, y1] = pol2cart(angles(1), 10);
  [x2, y2] = pol2cart(angles(2), 10);
  plot([s(1), x1], [s(2), y1], 'r');
  plot([s(1), x2], [s(2), y2], 'r');
  plot([s(1), (CartPoints(ind1, 1))], [s(2), (CartPoints(ind1, 2))], 'black');
  plot([s(1), (CartPoints(ind2, 1))], [s(2), (CartPoints(ind2, 2))], 'black');
  [m1, m2] = pol2cart(midth, 10);
  plot([s(1), m1], [s(2), m2], 'cyan');
end

end

function rss = SliceFitting(angles, points)

StartPoint = [0, 0];
[x1, y1] = pol2cart(angles(1), 1000);
[x2, y2] = pol2cart(angles(2), 1000);

distance1 = DistanceLine(StartPoint, [x1, y1], points);
distance2 = DistanceLine(StartPoint, [x2, y2], points);

rss = mean([distance1; distance2]);

end
