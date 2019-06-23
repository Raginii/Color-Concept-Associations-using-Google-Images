function [WcsColourTable, GroundTruth] = ColourMembershipExperiment()
%ColourMembershipExperiment Summary of this function goes here
%   Detailed explanation goes here

FunctionLocalPath = 'matlab/src/experiments/wcs/ColourMembershipExperiment';
FunctionPath = mfilename('fullpath');
MembershipRGBPath = strrep(FunctionPath, FunctionLocalPath, 'data/ColourNaming/MembershipValues_sRGB.txt');

MembershipRGB = tdfread(MembershipRGBPath);

RGBPoints = [MembershipRGB.R, MembershipRGB.G, MembershipRGB.B];

npoints = size(MembershipRGB.Red, 1);
MembershipValues = zeros(npoints, 11);

MembershipValues(:, 1) = MembershipRGB.Green;
MembershipValues(:, 2) = MembershipRGB.Blue;
MembershipValues(:, 3) = MembershipRGB.Purple;
MembershipValues(:, 4) = MembershipRGB.Pink;
MembershipValues(:, 5) = MembershipRGB.Red;
MembershipValues(:, 6) = MembershipRGB.Orange;
MembershipValues(:, 7) = MembershipRGB.Yellow;
MembershipValues(:, 8) = MembershipRGB.Brown;
MembershipValues(:, 9) = MembershipRGB.Grey;
MembershipValues(:, 10) = MembershipRGB.White;
MembershipValues(:, 11) = MembershipRGB.Black;

MembershipValues(:, :, :) = MembershipValues(:, :, :) ./ 10;

DesiredCols = 43;
rows = ceil(npoints / DesiredCols);
nexpanded = rows * DesiredCols;
cols = nexpanded / rows;

RGBPoints(npoints:nexpanded, 3) = 0;
MembershipValues(npoints:nexpanded, 1, :) = 0;

x = 1;
y = 1;
WcsColourTable = zeros(rows, cols, 3);
GroundTruth = zeros(rows, cols, 11);
for i = 1:npoints
  WcsColourTable(x, y, :) = RGBPoints(i, :);
  GroundTruth(x, y, :) = MembershipValues(i, :);
  x = x + 1;
  if x == rows + 1
    x = 1;
    y = y + 1;
  end
end

WcsColourTable = uint8(WcsColourTable);

end
