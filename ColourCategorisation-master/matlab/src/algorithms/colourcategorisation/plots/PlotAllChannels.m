function FigureHandler = PlotAllChannels(ImageRGB, BelongingImage, EllipsoidsTitles, EllipsoidsRGBs, FigureTitle)
%PlotAllChannels  plots all the channels of the belonging image.

if nargin < 3
  EllipsoidsTitles = [];
  EllipsoidsRGBs = [];
  FigureTitle = [];
end

if isempty(EllipsoidsTitles)
  FunctionLocalPath = 'matlab/src/algorithms/colourcategorisation/plots/PlotAllChannels';
  FunctionPath = mfilename('fullpath');
  EllipsoidDicMatPath = strrep(FunctionPath, FunctionLocalPath, 'matlab/data/mats/EllipsoidDic.mat');
  EllipsoidDicMat = load(EllipsoidDicMatPath);
  ncolours = size(BelongingImage, 3);
  for i = 1:ncolours
    EllipsoidsTitles{1, i} = EllipsoidDicMat.EllipsoidDic{1, i};
  end
end

if isempty(EllipsoidsRGBs)
  ncolours = size(EllipsoidsTitles, 2);
  EllipsoidsRGBs = zeros(ncolours, 3);
  for i = 1:ncolours
    EllipsoidsRGBs(i, :) = name2rgb(EllipsoidsTitles{i});
  end
end

if isempty(FigureTitle)
  FigureTitle = 'Colour Categorisation';
end

titles = EllipsoidsTitles;
if nargout > 0
  visibility = 'off';
else
  visibility = 'on';
end
FigureHandler = figure('NumberTitle', 'Off', 'Name', FigureTitle, 'visible', visibility);
subplot(4, 4, 1.5);
imshow(ImageRGB);
title('Org');
subplot(4, 4, 3.5);
ColouredBelongingImage = ColourBelongingImage(BelongingImage, EllipsoidsRGBs);
imshow(ColouredBelongingImage);
title('Max');

[~, ~, nelpisd] = size(BelongingImage);
for i = 1:nelpisd
  PlotIndex = i + 4;
  if PlotIndex > 12
    PlotIndex = PlotIndex + 0.5;
  end
  subplot(4, 4, PlotIndex);
  imshow(BelongingImage(:, :, i), [0, 1]);
  title(titles{i});
end

end

function ColouredBelongingImage = ColourBelongingImage(BelongingImage, EllipsoidsRGBs)

inds = belonging2naming(BelongingImage);
ColouredBelongingImage = ColourLabelImage(inds, EllipsoidsRGBs);

end
