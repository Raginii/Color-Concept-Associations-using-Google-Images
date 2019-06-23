function [FocalChipsTable, DomainChipsTable] = DomainColourBoundries()
%DomainColourBoundries Summary of this function goes here
%   Detailed explanation goes here

FunctionPath = mfilename('fullpath');
ChipsTablePath = strrep(FunctionPath, 'matlab/src/experiments/wcs/DomainColourBoundries', 'matlab/data/mats/DomainColourBoundries.mat');
ChipsTableMat = load(ChipsTablePath);

FocalChipsTable1 = WcsResults({'benavente'});
FocalChipsTable2 = WcsResults({'sturges'});
FocalChipsTable3 = WcsResults({'berlin'});
FocalChipsTable = max(max(FocalChipsTable1, FocalChipsTable2), FocalChipsTable3);
% FocalChipsTable = WcsResults({'berlin', 'sturges', 'benavente'});
% FocalChipsTable = ChipsTableMat.FocalChipsTable();
DomainChipsTable = ChipsTableMat.DomainChipsTable();

end
