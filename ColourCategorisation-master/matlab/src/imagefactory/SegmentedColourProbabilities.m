function [ColourBoxesImage, GroundTruthImage] = SegmentedColourProbabilities(DirPath, nLimistPoitns)

if nargin < 1
  DirPath = '/home/arash/Software/Repositories/neurobit/data/dataset/ColourNameDataset/ebay/';
end

if isempty(strfind(DirPath, '.mat'))
  if nargin < 2
    nLimistPoitns = 1000;
  end
  [rgbs, gts] = SegmentedColourPoints(DirPath, nLimistPoitns);
else
  [rgbs, gts] = SegmentedColourPoints(DirPath);
end

quantize = 4;
rgbs = floor(double(rgbs) ./ quantize) + 1;

[ColourBoxesImage, ~, IndUniqes] = unique(rgbs, 'rows');
ColourBoxesImage = uint8(ColourBoxesImage .* quantize - 1);

OriginalDimension = size(rgbs, 1);
UniqueDimension = size(ColourBoxesImage, 1);
GroundTruthImage = zeros(UniqueDimension, 1, 11);

for i = 1:OriginalDimension
  GroundTruthImage(IndUniqes(i), 1, :) = GroundTruthImage(IndUniqes(i), 1, :) + gts(i, 1, :);
end

SumProbs = sum(GroundTruthImage, 3);
for i = 1:UniqueDimension
  GroundTruthImage(i, 1, :) = GroundTruthImage(i, 1, :) ./ SumProbs(i);
end

end
