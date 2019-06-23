function [ColourBoxesImage, GroundTruthImage] = ColourBoxes(scale)
%ColourBoxes creates set of focal colours.
%
% inputs
%   scale  should the 13x9 board be scaled, default is 1.
%
% outputs
%   ColourBoxesImage  the colour boxes if scale is not given in size 13x9.
%   GroundTruth       the probability map of eleven focal colours.
%

if nargin < 1
  scale = 1;
end

cboxes = zeros(9, 13, 3);
cboxes(:, :, 1) = ...
  [
  51,   51,  51,  25,   0,   0,   0,   0,   0,  25,  51,  51,   0;
  102, 102, 102,  51,   0,   0,   0,   0,   0,  51, 102, 102,  32;
  153, 153, 153,  76,   0,   0,   0,   0,   0,  76, 153, 153,  64;
  204, 204, 204, 102,   0,   0,   0,   0,   0, 102, 204, 204,  96;
  255, 255, 255, 128,   0,   0,   0,   0,   0, 128, 255, 255, 128;
  255, 255, 255, 153,  51,  51,  51,  51,  51, 153, 255, 255, 160;
  255, 255, 255, 178, 102, 102, 102, 102, 102, 178, 255, 255, 192;
  255, 255, 255, 204, 153, 153, 153, 153, 153, 204, 255, 255, 224;
  255, 255, 255, 229, 204, 204, 204, 204, 204, 229, 255, 255, 255;
  ];
cboxes(:, :, 2) = ...
  [
  0,    25,  51,  51,  51,  51,  51,  25,   0,   0,   0,   0,   0;
  0,    51, 102, 102, 102, 102, 102,  51,   0,   0,   0,   0,  32;
  0,    76, 153, 153, 153, 153, 153,  76,   0,   0,   0,   0,  64;
  0,   102, 204, 204, 204, 204, 204, 102,   0,   0,   0,   0,  96;
  0,   128, 255, 255, 255, 255, 255, 128,   0,   0,   0,   0, 128;
  51,  153, 255, 255, 255, 255, 255, 153,  51,  51,  51,  51, 160;
  102, 178, 255, 255, 255, 255, 255, 178, 102, 102, 102, 102, 192;
  153, 204, 255, 255, 255, 255, 255, 204, 153, 153, 153, 153, 224;
  204, 229, 255, 255, 255, 255, 255, 229, 204, 204, 204, 204, 255;
  ];
cboxes(:, :, 3) = ...
  [
  0,     0,   0,   0,   0,  25,  51,  51,  51,  51,  51,  25,   0;
  0,     0,   0,   0,   0,  51, 102, 102, 102, 102, 102,  51,  32;
  0,     0,   0,   0,   0,  76, 153, 153, 153, 153, 153,  76,  64;
  0,     0,   0,   0,   0, 102, 204, 204, 204, 204, 204, 102,  96;
  0,     0,   0,   0,   0, 128, 255, 255, 255, 255, 255, 128, 128;
  51,   51,  51,  51,  51, 153, 255, 255, 255, 255, 255, 153, 160;
  102, 102, 102, 102, 102, 178, 255, 255, 255, 255, 255, 178, 192;
  153, 153, 153, 153, 153, 204, 255, 255, 255, 255, 255, 204, 224;
  204, 204, 204, 204, 204, 229, 255, 255, 255, 255, 255, 229, 255;
  ];

ColourBoxesImage = MatRowsColsRepeat(cboxes, scale);
ColourBoxesImage = uint8(ColourBoxesImage);

FunctionPath = mfilename('fullpath');
ChipsTablePath = strrep(FunctionPath, 'matlab/src/imagefactory/ColourBoxes', 'matlab/data/mats/gts/ColourBoxesGroundTruth.mat');
ChipsTableMat = load(ChipsTablePath);

GroundTruth = ChipsTableMat.ChipsTable();
GroundTruthImage = MatRowsColsRepeat(GroundTruth, scale);

end
