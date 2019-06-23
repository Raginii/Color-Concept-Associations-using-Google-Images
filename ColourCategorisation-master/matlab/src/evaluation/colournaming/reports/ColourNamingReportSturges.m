function ColourContingencyTable = ColourNamingReportSturges(method, plotdiff)
%ColourNamingReportSturges  testing colour naming algorithm with sturge GT.
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

ImageMask = WcsResults({'sturges'});
ColourContingencyTable = ColourNamingComputeError(ImageMask, NamingImage, 'all');

if plotdiff
  PlotColourNamingDifferences(BelongingImage, ImageMask);
end

end
