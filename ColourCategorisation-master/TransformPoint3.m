function TransformedPoint = TransformPoint3(point, trans)
%TransformPoint3 transforming point with the given transformation.
%
% Inputs
%   point  the point in 3D.
%   trans  the transformation matrix.
%
% Outputs
%   TransformedPoint the transformed point.
%

[rows, cols, chns] = size(point);
if chns == 3
  x = point(:, :, 1);
  y = point(:, :, 2);
  z = point(:, :, 3);
  np = rows * cols;
elseif cols == 3
  x = point(:, 1);
  y = point(:, 2);
  z = point(:, 3);
  np = rows;
else
  x = point(1, :);
  y = point(2, :);
  z = point(3, :);
  np = cols;
end

point = [x(:), y(:), z(:), ones(np, 1, class(point))] * trans;
TransformedPoint = point(:, 1:3) ./ [point(:, 4), point(:, 4), point(:, 4)];

if chns == 3
  TransformedPoint = reshape(TransformedPoint, rows, cols, chns);
end

end
