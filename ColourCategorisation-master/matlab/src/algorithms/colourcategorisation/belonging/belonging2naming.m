function [NamingImage, MaxProbabilityImage] = belonging2naming(BelongingImage, DecideAllPixels, ChromVsAchrom)
%BELONGING2NAMING  gets the maximum value of the all channels in the
%                  belonging image.
%
% inputs
%   BelongingImage   the belonging image each channel for one colour.
%   DecideAllPixels  if true all pixels will be assigned to a colour, if
%                    false the pixels with maximum value of 0 are labeld as
%                    -1. default is false.
%   ChromVsAchrom    if true, a pixel is first decided to be chromatic or
%                    achromatic, next it will be assigned to a specific
%                    colour. default is false.
%
% outputs
%   NamingImage          index of the salient colour.
%   MaxProbabilityImage  the probability of each pixel.
%

if nargin < 3
  ChromVsAchrom = false;
end
if nargin < 2
  DecideAllPixels = false;
end

[rows, cols, chns] = size(BelongingImage);

if chns > 1
  BelongingImage = reshape(BelongingImage, rows * cols, chns);
end

if ChromVsAchrom
  ChromAchrom(:, 1) = sum(BelongingImage(:, 1:8), 2);
  ChromAchrom(:, 2) = sum(BelongingImage(:, 9:11), 2);
  [~, IndsChromAchrom] = max(ChromAchrom, [], 2);
  
  [ValsChrom, IndsChrom] = max(BelongingImage(:, 1:8), [], 2);
  [ValsAchrom, IndsAchrom] = max(BelongingImage(:, 9:11), [], 2);
  
  NamingImage = zeros(size(IndsChrom));
  MaxProbabilityImage = zeros(size(ValsAchrom));
  
  NamingImage(IndsChromAchrom == 1) = IndsChrom(IndsChromAchrom == 1);
  MaxProbabilityImage(IndsChromAchrom == 1) = ValsChrom(IndsChromAchrom == 1);
  NamingImage(IndsChromAchrom == 2) = IndsAchrom(IndsChromAchrom == 2) + 8;
  MaxProbabilityImage(IndsChromAchrom == 2) = ValsAchrom(IndsChromAchrom == 2);
else
  [MaxProbabilityImage, NamingImage] = max(BelongingImage, [], 2);
end

if ~DecideAllPixels
  % if the maximum value is 0 it means neither of the colours did categorise
  % this pixel.
  NamingImage(MaxProbabilityImage == 0) = -1;
  MaxProbabilityImage(MaxProbabilityImage == 0) = -1;
end

if chns > 1
  NamingImage = reshape(NamingImage, rows, cols);
  MaxProbabilityImage = reshape(MaxProbabilityImage, rows, cols);
end

end
