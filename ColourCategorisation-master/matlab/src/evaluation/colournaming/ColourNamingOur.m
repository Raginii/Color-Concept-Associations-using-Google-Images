function [NamingImage, BelongingImage] = ColourNamingOur(ImageRGB, ConfigsMat, DoPostProcessing)

if nargin < 3
  DoPostProcessing = false;
end

BelongingImage = rgb2belonging(ImageRGB, ConfigsMat);
if DoPostProcessing
  BelongingImage = PostProcessBelongingImage(ImageRGB, BelongingImage);
end
NamingImage = belonging2naming(BelongingImage, true);

end
