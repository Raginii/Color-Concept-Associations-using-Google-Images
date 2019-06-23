function ChipsTable = SturgesWhitfielColourBoundries()
%SturgesWhitfielColourBoundries Summary of this function goes here
%   Detailed explanation goes here

FunctionPath = mfilename('fullpath');
ChipsTablePath = strrep(FunctionPath, 'matlab/src/experiments/wcs/SturgesWhitfielColourBoundries', 'matlab/data/mats/SturgesWhitfielColourBoundries.mat');
ChipsTableMat = load(ChipsTablePath);

ChipsTable = ChipsTableMat.ChipsTable();

% green
ChipsTable(7, 19, 1) = 1;

% blue
ChipsTable(6, 30, 2) = 1;

% purple
ChipsTable(7, 35, 3) = 1;

% pink
ChipsTable(4, 40, 4) = 1;

% red
ChipsTable(7, 4, 5) = 1;

% orange
ChipsTable(5, 6, 6) = 1;

% yellow
ChipsTable(2, 11, 7) = 1;

% brown
ChipsTable(8, 9, 8) = 1;

% grey
ChipsTable(5:6, 1, 9) = 1;

% white
ChipsTable(1, 1, 10) = 1;

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

end
