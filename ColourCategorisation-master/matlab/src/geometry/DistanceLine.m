function EuclideanDistance = DistanceLine(a, b, x)
%DistanceLine calculates distance from a set of poitns to a line.
%
% inputs
%   a  corrdinates of the start of line in a row, e.g [0, 0].
%   b  corrdinates of the end of line in a ros, e.g [1, 1].
%   x  coordinates of the points in rows, e.g [4, 5; 12, 19].
%
% outputs
%   EuclideanDistance  the distances of each point to the line.
%

[rows, ~] = size(x);
EuclideanDistance = zeros(rows, 1);

a = repmat(a, [rows, 1]);
b = repmat(b, [rows, 1]);

dab = sqrt((a(:, 1) - b(:, 1)) .^ 2 + (a(:, 2) - b(:, 2)) .^ 2 );
dax = sqrt((a(:, 1) - x(:, 1)) .^ 2 + (a(:, 2) - x(:, 2)) .^ 2 );
dbx = sqrt((b(:, 1) - x(:, 1)) .^ 2 + (b(:, 2) - x(:, 2)) .^ 2 );

DotProducts = dot(a - b, x - b, 2) .* dot(b - a, x - a, 2) >= 0;
determinants = ((a(:, 1) .* b(:, 2)) + ((a(:, 2) .* x(:, 1)) + (b(:, 1) .* x(:, 2)))) - ((b(:, 2) .* x(:, 1)) + (a(:, 2) .* b(:, 1)) + (a(:, 1) .* x(:, 2)));
EuclideanDistance(DotProducts) = abs(determinants(DotProducts)) ./ dab(DotProducts);
EuclideanDistance(~DotProducts) = min(dax(~DotProducts), dbx(~DotProducts));

end
