function [ColourBoxesImage, GroundTruthImage] = SegmentedColourPoints(DirPath, nLimistPoitns)

if nargin < 1
  DirPath = '/home/arash/Software/Repositories/neurobit/data/dataset/ColourNameDataset/ebay/';
end

if isempty(strfind(DirPath, '.mat'))
  if nargin < 2
    nLimistPoitns = 1000;
  end
  ColourPoints = EmptyColourPointsStruct();
  SubFolders = GetSubFolders(DirPath);
  for j = 1:length(SubFolders)
    DirPathJ = [DirPath, SubFolders{j}, '/'];
    
    ColourPointsSubCat = EmptyColourPointsStruct();
    SubSubFolders = GetSubFolders(DirPathJ);
    for k = 1:length(SubSubFolders)
      DirPathJK = [DirPathJ, SubSubFolders{k}, '/'];
      ColourName = lower(SubSubFolders{k});
      
      ImageFiles = dir([DirPathJK, '*.jpg']);
      MaskFiles = dir([DirPathJK, '*.png']);
      nimages = length(ImageFiles);
      if nimages ~= length(MaskFiles)
        warning(['Directory ', DirPathJK, ' does not have same number of pictures and gts.']);
        continue;
      end
      for i = 1:nimages
        ImagePath = [DirPathJK, ImageFiles(i).name];
        ImageRGB = imread(ImagePath);
        [rows, cols, ~] = size(ImageRGB);
        ImageRGB = reshape(ImageRGB, rows * cols, 3);
        
        MaskPath = [DirPathJK, MaskFiles(i).name];
        ImageMask = im2bw(imread(MaskPath));
        ImageMask = reshape(ImageMask, rows * cols, 1);
        
        CurrentPoints = ImageRGB(ImageMask, :);
        nCurrentPoitns = size(CurrentPoints, 1);
        if nCurrentPoitns > nLimistPoitns
          RandomPoints = randi(nCurrentPoitns, [nLimistPoitns, 1]);
          CurrentPoints = CurrentPoints(RandomPoints, :);
        end
        ColourPointsSubCat.(ColourName) = [ColourPointsSubCat.(ColourName); CurrentPoints];
        ColourPoints.(ColourName) = [ColourPoints.(ColourName); CurrentPoints];
      end
    end
    SaveColourPoints(DirPathJ, ColourPointsSubCat);
  end
  SaveColourPoints(DirPath, ColourPoints);
  
else
  SegmentedColourPointsMat = load(DirPath);
  ColourPoints = SegmentedColourPointsMat.ColourPoints;
end

[ColourBoxesImage, GroundTruthImage] = ColourStruct2MatChans(ColourPoints);

end

function ColourPoints = EmptyColourPointsStruct()

ColourPoints = struct();
ColourPoints.green = [];
ColourPoints.blue = [];
ColourPoints.purple = [];
ColourPoints.pink = [];
ColourPoints.red = [];
ColourPoints.orange = [];
ColourPoints.yellow = [];
ColourPoints.brown = [];
ColourPoints.grey = [];
ColourPoints.white = [];
ColourPoints.black = [];

end

function [] = SaveColourPoints(DirPath, ColourPoints) %#ok

save([DirPath, 'ColourPoints.mat'], 'ColourPoints');

end
