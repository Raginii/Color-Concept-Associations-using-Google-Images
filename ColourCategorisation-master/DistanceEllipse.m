function [distance, intersection] = DistanceEllipse(points, ellipse, plotme)
%DistanceEllipse  distance from points to ellipse.
%
% inputs
%   points   the polar coordinates of the poitns [x, y].
%   ellipse  ellipse parameters; [cx, cy, ax, ay, rx]
%   plotme   if true it plots the poitns and the ellipse.
%
% outputs
%   distance      the distance from the point to the ellipse.
%   intersection  the intersection points on ellipse surface.
%

if nargin < 3
  plotme = 0;
end

cx = ellipse(1);
cy = ellipse(2);
ax = ellipse(3);
ay = ellipse(4) + 1e-10; % to avoid division by 0
rx = ellipse(5);

[rows, ~] = size(points);

s = sin(rx);
c = cos(rx);
rot = [c, -s; s, c];
TransferedPoint = [points(:, 1) - cx, points(:, 2) - cy] * rot;

px = TransferedPoint(:, 1) + 1e-10; % to avoid division by 0
py = TransferedPoint(:, 2);

% calculate the intersection points on the surface
x1 = 1 ./ sqrt(1 ./ (ax .^ 2) + (py ./ px ./ ay) .^ 2);
x2 = -x1;
y1 = py ./ px .* x1;
y2 = -y1;

% calculating the distance to the point
d1 = sqrt((px - x1) .^ 2 + (py - y1) .^ 2);
d2 = sqrt((px - x2) .^ 2 + (py - y2) .^ 2);
distance = min(d1, d2);

% closest points in the ellipse
intersection = [x1, y1] .* [(d1 <= d2), (d1 <= d2)] + [x2, y2] .* [(d1 >= d2), (d1 >= d2)];

% transferring it back with the rotation and translation
% intersection = TransformPoint3(intersection, rot');
intersection = intersection * rot';
intersection = intersection + repmat([cx, cy], [rows, 1]);

if plotme
  figure;
  DrawEllipse(ellipse, 'color', 'g', 'linestyle', '-');
  hold on;
  
  % plotting the centre
  plot(cx, cy, '*m');
  
  % plotting the intesection point
  plot(intersection(:, 1), intersection(:, 2), '*r');
  
  % plotting all the original points
  plot(points(:, 1), points(:, 2), '*b');
  
  % plotting a line between the centre and the points
  for i = 1:rows
    plot([cx, points(i, 1)], [cy, points(i, 2)], 'black');
  end
  hold off;
end

end
