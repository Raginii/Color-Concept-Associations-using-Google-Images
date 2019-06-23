function MapGradient = brushfire(MapGrid, connectivity, xcircle, ycircle)
%BRUSHFIRE  algorithm computes the gradient map.
%   Considering the provided connectivity, the gradient map shows the
%   distance of each position towards the closest obstacle. Obstacles are
%   defined with index value of 1. All the points with index value of 0 are
%   ignored.
%
% inputs
%   MapGrid       the map of environment.
%   connectivity  4 or 8 adjacency.
%   xcircle       if matrix is circular is x direction, default false.
%   ycircle       if matrix is circular is y direction, default false.
%
% outputs
%   MapGradient the gradient map of environment.
%

if nargin < 3
  xcircle = false;
  ycircle = false;
end

[rows, cols] = size(MapGrid);

MapGradient = zeros(rows, cols);
MapGradient(MapGrid == 1 ) = 1;

label = 1;

% We iterate through all the points untill there are are no more changes in
% the gradient map.
while 1
  TempMap = MapGradient;
  for i = 1 : rows
    for j = 1 : cols
      if MapGrid(i, j) == 0
        continue;
      end
      % If the current position has a label lower than number of
      % iterations, it means this position has the correct label.
      % However if the label is less than number of iterations, it
      % means theorethically we might be able to change that lable,
      % considering the situations that the obstacle is on the right
      % or bottom of current positions.
      if MapGradient(i, j) > label || MapGradient(i, j) == 0
        MapGradient(i, j) = CheckNeighbours(MapGradient, [i, j], connectivity, xcircle, ycircle);
      end
    end
  end
  
  % Calculating the difference between this iteration gradient map and
  % the previous one.
  difference = double(TempMap) - double(MapGradient);
  
  % If there is no difference between the current and old gradient map,
  % we have rached the correct gradient map.
  if max(max(difference)) == 0 && min(min(difference)) == 0
    break;
  end
  
  label = label + 1;
end

end
