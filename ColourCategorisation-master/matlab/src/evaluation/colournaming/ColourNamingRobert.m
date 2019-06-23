function [NamingImage, BelongingImage] = ColourNamingRobert(ImageRGB, ConfigsMat, ConversionMat)

ImageRGB = double(ImageRGB);
[~, NamingImage, BelongingImage] = ImColorNamingTSELab(ImageRGB, ConfigsMat.ParFileName1, ConfigsMat.ParFileName2, ConfigsMat.ParFileName3);

NamingImageTmp = NamingImage;
BelongingImageTmp = BelongingImage;
for i = 1:11
  BelongingImage(:, :, ConversionMat(i)) = BelongingImageTmp(:, :, i);
  NamingImage(NamingImageTmp == i) = ConversionMat(i);
end

end
