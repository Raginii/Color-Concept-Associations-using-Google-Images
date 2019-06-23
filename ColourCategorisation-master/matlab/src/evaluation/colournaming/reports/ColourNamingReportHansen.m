function ColourContingencyTable = ColourNamingReportHansen()
%ColourNamingReportHansen Summary of this function goes here
%   Detailed explanation goes here

load('HansenMat');
ColourPoints(418:420, :) = 0;
GroundTruth(418:420, 1, :) = 0;

ColourPoints = reshape(ColourPoints, 20, 21, 3);
GroundTruth = reshape(GroundTruth, 20, 21, 11);

PlotAllChannels(ColourPoints, GroundTruth);

plotme = true;
[BelongingImage, NamingImage] = ColourNamingTestImage(ColourPoints, 'ourlsy', plotme);

ImageMask = belonging2naming(GroundTruth);

ColourContingencyTable = ColourNamingComputeError(ImageMask, NamingImage, 'all');

ColourFieldNames = fieldnames(ColourContingencyTable);
for i = 1:11
  ErrorMats = ColourContingencyTable.(ColourFieldNames{i});
  disp(ColourFieldNames{i});
  fprintf('Sensitivity %0.2f Specificity %0.2f Positive predictive %0.2f Negative predictive %0.2f\n', ErrorMats.sens, ErrorMats.spec, ErrorMats.ppv, ErrorMats.npv);
  fprintf('TP %d FP %d TN %d FN %d\n', ErrorMats.tp, ErrorMats.fp, ErrorMats.tn, ErrorMats.fn);
end

% PlotColourNamingDifferences(BelongingImage, ImageMask);


end
