function ChipsTable = ArashColourBoundries()
%ArashColourBoundries Summary of this function goes here
%   Detailed explanation goes here

FunctionPath = mfilename('fullpath');
ChipsTablePath = strrep(FunctionPath, 'matlab/src/experiments/wcs/ArashColourBoundries', 'matlab/data/mats/ArashColourBoundries.mat');
ChipsTableMat = load(ChipsTablePath);

ChipsTable = ChipsTableMat.ChipsTable();

end
