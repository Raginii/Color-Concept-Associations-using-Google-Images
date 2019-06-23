function neighbours = GetNeighbours(MapGrid, pixel, connectivity, xcircle, ycircle)
%GetNeighbours  returns the valid neighbours of a pixel.
%
% Inputs
%   MapGrid       the matrix of map.
%   pixel         the pixel that we want to get the neighborus.
%   connectivity  4 or 8 neighbourhood.
%   xcircle       if matrix is circular is x direction, default false.
%   ycircle       if matrix is circular is y direction, default false.
%
% Outputs
%   neighbours  list of neighbours. If x and y of one neighbour is 0, it.
%   means       that neighboru is not valid.
%

if nargin < 4
  xcircle = false;
  ycircle = false;
end

[rows, cols] = size(MapGrid);

% extracting information for current pixel.
i = pixel(1);
j = pixel(2);

% check which neighborhood we have to use.
if connectivity == 4
  souroundings = [0, 1, 0, -1; -1, 0, 1, 0;];
elseif connectivity == 8
  souroundings = [0, 1, 0, -1, 1, 1, -1, -1; -1, 0, 1, 0, 1, -1, 1, -1;];
end

neighbours = zeros(2, connectivity);

for k = 1 : size(souroundings, 2)
  temp = [i; j] + souroundings(:, k);
  % if the neighbour is out of boundry we don't add it to list.
  if temp(1) <= 0
    if ycircle
      temp(1) = rows;
    else
      continue;
    end
  elseif temp(1) > rows
    if ycircle
      temp(1) = 1;
    else
      continue;
    end
  end
  if temp(2) <= 0
    if xcircle
      temp(2) = cols;
    else
      continue;
    end
  elseif temp(2) > cols
    if xcircle
      temp(2) = 1;
    else
      continue;
    end
  end
  neighbours(:, k) = temp;
end
