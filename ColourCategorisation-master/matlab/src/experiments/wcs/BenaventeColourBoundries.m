function ChipsTable = BenaventeColourBoundries()
%BenaventeColourBoundries Summary of this function goes here
%   Detailed explanation goes here

FunctionPath = mfilename('fullpath');
ChipsTablePath = strrep(FunctionPath, 'matlab/src/experiments/wcs/BenaventeColourBoundries', 'matlab/data/mats/BenaventeColourBoundries.mat');
ChipsTableMat = load(ChipsTablePath);

ChipsTable = ChipsTableMat.ChipsTable();

% green
ChipsTable(6:7, 18, 1) = 1;

% blue
ChipsTable(6:7, 28:30, 2) = 1;

% purple
ChipsTable(8:9, 36, 3) = 1;

% pink
ChipsTable(4:5, 39, 4) = 1;

% red
ChipsTable(7:8, 4, 5) = 1;

% orange
ChipsTable(6, 5, 6) = 1;

% yellow
ChipsTable(3, 10, 7) = 1;

% brown
ChipsTable(9, 6:8, 8) = 1;

% grey
ChipsTable(6, 1, 9) = 1;

% white
ChipsTable(1:2, 1, 10) = 1;

% black
ChipsTable(10, 1, 11) = 1;

% calculating the distances
d = 0.05;

[rows, cols, ~] = size(ChipsTable);

for i = 1:8
  GradientMap = brushfire(ChipsTable(2:rows-1, 2:cols, i), 8, true, false);
  GradientMap(GradientMap > 0) = 1 - (GradientMap(GradientMap > 0) - 1) * d;
  ChipsTable(2:rows-1, 2:cols, i) = GradientMap;
end

for i = 9:11
  GradientMap = brushfire(ChipsTable(:, :, i), 8, true, false);
  GradientMap(GradientMap > 0) = 1 - (GradientMap(GradientMap > 0) - 1) * d;
  ChipsTable(:, :, i) = GradientMap;
end

end
