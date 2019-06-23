function h = PlotColourNamingDifferences(ResBelonging, GtBelonging)
%PlotColourNamingDifferences Summary of this function goes here
%   Detailed explanation goes here


ColouredBelongingImage = belonging2naming(ResBelonging);
[ErrorIndsB, GtIndsB] = CompareResultGroundTruth(ColouredBelongingImage, belonging2naming(GtBelonging));
ErrorIndsB([1, 10], 2:end) = 0;
GtIndsB([1, 10], 2:end) = 0;

PrintDiffGt(ErrorIndsB, ResBelonging, GtIndsB);

h = figure;
subplot(121);image(ColourLabelImage(ErrorIndsB));
subplot(122);image(ColourLabelImage(GtIndsB));

end

function [] = PrintDiffGt(ErrorInds, BelongingImage, GtInds)

[rows, cols, ~] = size(BelongingImage);
diff = ErrorInds - GtInds;

for i = 1:rows
  for j = 1:cols
    if diff(i, j) ~= 0
      fprintf('Us [%d, %f] - GT [%d, %f]\n', ErrorInds(i, j), BelongingImage(i, j, ErrorInds(i, j)), GtInds(i, j), BelongingImage(i, j, GtInds(i, j)));
    end
  end
end

end