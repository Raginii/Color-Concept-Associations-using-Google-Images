function [distance, intersection] = DistanceEllipsoid(points, ellipsoid, plotme)
%DistanceEllipsoid  distance from points to ellipsoid.
%
% inputs
%   points     the polar coordinates of the poitns [x, y, z].
%   ellipsoid  ellipsoid parameters; [cx, cy, cz, ax, ay, az, rx, ry, rz]
%   plotme     if true it plots the poitns and the ellipsoid.
%
% outputs
%   distance      the distance from the point to the ellipsoid.
%   intersection  the intersection points on ellipsoid surface.
%

if nargin < 3
  plotme = 0;
end

cx = ellipsoid(1);
cy = ellipsoid(2);
cz = ellipsoid(3);
ax = ellipsoid(4);
ay = ellipsoid(5) + 1e-10; % to avoid division by 0
az = ellipsoid(6) + 1e-10; % to avoid division by 0
rx = ellipsoid(7);
ry = ellipsoid(8);
rz = ellipsoid(9);

[rows, ~] = size(points);

% centre the points relatively to the ellipsoid.
TransferedPoint = points - repmat([cx, cy, cz], [rows, 1]);

% rotate all points an angle alpha so that we can reduce the problem to
% one of canonical ellipsoids
rotx = CreateRotationX(rx);
roty = CreateRotationY(ry);
rotz = CreateRotationZ(rz);
rot = rotz * roty * rotx;
TransferedPoint = TransformPoint3(TransferedPoint, rot);

px = TransferedPoint(:, 1) + 1e-10; % to avoid division by 0
py = TransferedPoint(:, 2);
pz = TransferedPoint(:, 3);

% calculate the intersection points on the surface
x1 = 1 ./ sqrt(1 ./ (ax .^ 2) + (py ./ px ./ ay) .^ 2 + (pz ./ px ./ az) .^ 2);
x2 = -x1;
y1 = py ./ px .* x1;
y2 = -y1;
z1 = pz ./ px .* x1;
z2 = -z1;

% calculating the distance to the point
d1 = sqrt((px - x1) .^ 2 + (py - y1) .^ 2 + (pz - z1) .^ 2);
d2 = sqrt((px - x2) .^ 2 + (py - y2) .^ 2 + (pz - z2) .^ 2);
distance = min(d1, d2);

% closest points in the ellipse
intersection = [x1, y1, z1] .* [(d1 <= d2), (d1 <= d2), (d1 <= d2)] + [x2, y2, z2] .* [(d1 >= d2), (d1 >= d2), (d1 >= d2)];

% transferring it back with the rotation and translation
intersection = TransformPoint3(intersection, rot');
intersection = intersection + repmat([cx, cy, cz], [rows, 1]);

if plotme
  figure;
  DrawEllipsoid(ellipsoid, 'EdgeColor', 'g', 'FaceAlpha', 0.1, 'linestyle', '-');
  hold on;
  
  % plotting the centre
  plot3(cx, cy, cz, '*m');
  
  % plotting the intesection point
  plot3(intersection(:, 1), intersection(:, 2), intersection(:, 3), '*r');
  
  % plotting all the original points
  plot3(points(:, 1), points(:, 2), points(:, 3), '*b');
  
  % plotting a line between the centre and the points
  for i = 1:rows
    plot3([cx, points(i, 1)], [cy, points(i, 2)], [cz, points(i, 3)], 'black');
  end
  hold off;
end

end
