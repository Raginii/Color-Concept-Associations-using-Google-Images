function PostProcessedImage = PostProcessBelongingImage(ImageRGB, BelongingImage, rows, cols, plotme)
%PostProcessBelongingImage Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
  rows = [];
  cols = [];
end
if nargin < 5
  plotme = 0;
end

if ~isempty(rows) && ~isempty(cols)
  [~, chns] = size(BelongingImage);
  BelongingImage = reshape(BelongingImage, rows, cols, chns);
end

PostProcessedImage = BelongingImage;

for i = 1:3
  PostProcessedImage = ApplyGaussian(PostProcessedImage);
end

% PostProcessedImage = ApplyMedian(BelongingImage);
% ApplyNeighbourColours(PostProcessedImage, ImageRGB);

if ~isempty(rows) && ~isempty(cols)
  PostProcessedImage = reshape(PostProcessedImage, rows * cols, chns);
end

if plotme
  PlotAllChannels(ImageRGB, PostProcessedImage, [], [], 'Colour Categorisation - Post Processed Image');
end

end

function PostProcessedImage = ApplyNeighbourColours(BelongingImage, ImageRGB)

[rows, cols, chns] = size(BelongingImage);
BelongingImageRows = reshape(BelongingImage, rows * cols, chns);

PostProcessedImage = zeros(rows, cols, chns);

[NamingImage, ~] = belonging2naming(BelongingImage);
NamingImageModified = reshape(NamingImage, rows * cols, 1);

ImageOpponent = double(applycform(ImageRGB, makecform('srgb2lab')));
ImageOpponent = reshape(ImageOpponent, rows * cols, 3);

for c1 = 1:chns
  neighbours = GetNeighbourColours(c1);
  for c2 = neighbours
    colour1 = NamingImage;
    colour1 = colour1 == c1;
    colour2 = NamingImage;
    colour2 = colour2 == c2;
    [b1, l1] = bwboundaries(colour1);
    [b2, l2] = bwboundaries(colour2);
    
    for i1 = 1:length(b1)
      border1 = b1{i1};
      Border1Length = size(border1, 1);
      if Border1Length < 100
        continue;
      end
      for i2 = 1:length(b2)
        border2 = b2{i2};
        Border2Length = size(border2, 1);
        if Border2Length < 100
          continue;
        end
        bw1 = l1;
        bw1 = bw1 == i1;
        bw2 = l2;
        bw2 = bw2 == i2;
        edge1 = edge(bw1);
        edge2 = edge(bw2);
        EdgeImage = zeros(rows, cols);
        EdgeImage(edge1 == 1) = 1;
        EdgeImage(edge2 == 1) = 1;
        [b0, ~] = bwboundaries(EdgeImage, 'noholes');
        if length(b0) == 1
          bw0 = zeros(rows, cols);
          bw0(bw1) = 1;
          bw0(bw2) = 2;
          BorderLineImage = nlfilter(bw0, [3, 3], @(x) BorderLine(x));
          BorderLinePoints1 = ImageOpponent(BorderLineImage == 1);
          lab1 = ImageOpponent(BorderLinePoints1, :);
          BorderLinePoints2 = ImageOpponent(BorderLineImage == 2);
          lab2 = ImageOpponent(BorderLinePoints2, :);
          diff = abs(mean(lab1) - mean(lab2));
          if diff < 3
            prob1 = mean(BelongingImageRows(BorderLinePoints1, c1));
            prob2 = mean(BelongingImageRows(BorderLinePoints2, c2));
            if prob1 > prob2
              NamingImageModified(bw1) = c1;
            else
              NamingImageModified(bw1) = c2;
            end
            %             figure; imshow(label2rgb(BorderLineImage));
          end
        end
      end
    end
  end
end

ConfigsMat = load('lab_ellipsoid_params');
NamingImageModified = reshape(NamingImageModified, rows, cols);
figure;
imshow(ColourLabelImage(NamingImageModified, ConfigsMat.RGBTitles));

end

function neighbours = GetNeighbourColours(colour)

switch colour
  case 1
    neighbours = [2, 7, 8];
  case 2
    neighbours = [1, 3];
  case 3
    neighbours = [2, 4, 5];
  case 4
    neighbours = [3, 5, 6];
  case 5
    neighbours = [3, 4, 6, 8];
  case 6
    neighbours = [4, 5, 7, 8];
  case 7
    neighbours = [1, 6, 8];
  case 8
    neighbours = [1, 5, 6, 7];
  case 9
    neighbours = 10;
  case 10
    neighbours = [10, 11];
  case 11
    neighbours = 9;
  otherwise
    neighbours = [];
end

end

function PostProcessedImage = ApplyGaussian(BelongingImage)

h = fspecial('gaussian', [15, 15], 0.5);

PostProcessedImage = ApplyFilter(BelongingImage, h);

end

function FilteredImage = ApplyFilter(BelongingImage, h)

[rows, cols, chns] = size(BelongingImage);
FilteredImage = zeros(rows, cols, chns);

for i = 1:chns
  CurrentChn = BelongingImage(:, :, i);
  CurrentChn = imfilter(CurrentChn, h);
  FilteredImage(:, :, i) = CurrentChn;
end

end
