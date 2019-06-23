function MeanImage = naming2mean(ImageRGB, NamingImage)
%NAMING2MEAN Summary of this function goes here
%   Detailed explanation goes here

[rows, cols, chns] = size(ImageRGB);
MeanImage = zeros(rows, cols, chns);

rchan = reshape(ImageRGB(:, :, 1), rows * cols, 1);
gchan = reshape(ImageRGB(:, :, 2), rows * cols, 1);
bchan = reshape(ImageRGB(:, :, 3), rows * cols, 1);

MaxLabel = max(max(NamingImage));
for i = 1:MaxLabel
  disp(['Handling label ' num2str(i)]);
  [bi, li] = bwboundaries(NamingImage == i, 'noholes');
  li = reshape(li, rows * cols, 1);
  for j = 1:length(bi)
    rregion = rchan(li == j);
    rchan(li == j) = mean(rregion);
    gregion = gchan(li == j);
    gchan(li == j) = mean(gregion);
    bregion = bchan(li == j);
    bchan(li == j) = mean(bregion);
  end
  %   figure; imshow(li);
end

MeanImage(:, :, 1) = reshape(rchan, rows, cols);
MeanImage(:, :, 2) = reshape(gchan, rows, cols);
MeanImage(:, :, 3) = reshape(bchan, rows, cols);
MeanImage = uint8(MeanImage);

figure; imshow(MeanImage);

end
