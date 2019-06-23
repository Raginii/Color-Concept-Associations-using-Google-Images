function ColouredImage = ColourLabelImage(LabeledImage, colours)
%ColourLabelImage  converts a labeled image to a coloured image
%
% inputs
%   LabeledImage  the image with channel containing the labels.
%   colours       the colour map to convert the labels to colours.
%
% outputs
%   ColouredImage  the coloured image.
%

if nargin < 2
  colours = {'G', 'B', 'Pp', 'Pk', 'R', 'O', 'Y', 'Br', 'Gr', 'W', 'Bl'};
end

if ~isnumeric(colours)
  colours = name2rgb(colours);
end

[rows, cols, ~] = size(LabeledImage);
chns = size(colours, 1);

minv = min(min(colours));
maxv = max(max(colours));
if minv >= 0.0 && minv <= 1.0 && maxv >= 0.0 && maxv <= 1.0
  colours = colours * 255;
end

ColouredImage = zeros(rows, cols, 3);
LabeledImage(:, :, 2) = LabeledImage(:, :, 1);
LabeledImage(:, :, 3) = LabeledImage(:, :, 1);

for i = 1:chns
  [mi, ~] = size(ColouredImage(LabeledImage == i));
  ColouredImage(LabeledImage == i) = reshape(repmat(colours(i, :), mi / 3, 1), mi, 1);
end

ColouredImage = uint8(ColouredImage);

end
