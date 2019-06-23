function ColourContingencyTable = ColourNamingReportBerlin(method, plotdiff)
%ColourNamingReportBerlin  testing colour naming algorithm with berlin GT.
%
% inputs
%   method    the method to be tested, by default 'ourlsy'.
%   plotdiff  if true the difference with GT is plotted, by default false.
%
% outputs
%   ColourContingencyTable  the contingency table for each colour.
%

if nargin < 1
  method = 'ourlsy';
end
if nargin < 2
  plotdiff = false;
end

plotme = false;
ImageRgb = WcsChart();
[BelongingImage, NamingImage] = ColourNamingTestImage(ImageRgb, method, plotme);

ImageMask = WcsResults({'berlin'});
ColourContingencyTable = ColourNamingComputeError(ImageMask, NamingImage, 'all');

if plotdiff
  PlotColourNamingDifferences(BelongingImage, ImageMask);
end

end
