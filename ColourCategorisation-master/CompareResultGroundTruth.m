function [ErrorInds, GtIngs] = CompareResultGroundTruth(ResultInds, GroundTruthInds)
%CompareResultGroundTruth Summary of this function goes here
%   Detailed explanation goes here

ResultPos = ResultInds;
ResultPos(GroundTruthInds == -1) = 0;

GroundTruthPos = GroundTruthInds;
GroundTruthPos(GroundTruthInds == -1) = 0;

DiffMat = ResultPos - GroundTruthPos;
DiffMat(DiffMat ~= 0) = 1;

ErrorInds = ResultInds;
ErrorInds(DiffMat == 0) = 0;

GtIngs = GroundTruthInds;
GtIngs(DiffMat == 0) = 0;

end
