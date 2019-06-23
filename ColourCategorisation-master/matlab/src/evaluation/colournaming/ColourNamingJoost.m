function [NamingImage, BelongingImage] = ColourNamingJoost(ImageRGB, ConfigsMat, ConversionMat)

ImageRGB = double(ImageRGB);
NamingImage = im2c(ImageRGB, ConfigsMat, 0);

[rows, cols, ~] = size(ImageRGB);
BelongingImage = zeros(rows, cols, 11);
NamingImageTmp = NamingImage;
for i = 1:11
  BelongingImage(:, :, ConversionMat(i)) = im2c(ImageRGB, ConfigsMat, i);
  NamingImage(NamingImageTmp == i) = ConversionMat(i);
end

end
