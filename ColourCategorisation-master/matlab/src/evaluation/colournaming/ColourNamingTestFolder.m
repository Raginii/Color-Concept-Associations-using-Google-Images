function ErrorMats = ColourNamingTestFolder(DirPath, method, EvaluateGroundTruth, GroundTruthColour)

if nargin < 3
  DirPath = '/home/arash/Software/Repositories/neurobit/data/dataset/ColourNameDataset/soccer/psv/';
  method = 'ourlab';
  EvaluateGroundTruth = false;
end

if strcmpi(method, 'ourlab')
  ConfigsMat = load('lab_ellipsoid_params');
  MethodNumber = 1;
elseif strcmpi(method, 'ourlsy')
  ConfigsMat = load('lsy_ellipsoid_params');
  MethodNumber = 1;
else
  EllipsoidDicMat = load('EllipsoidDic.mat');
  if strcmpi(method, 'joost')
    w2cmat = load('w2c.mat');
    ConfigsMat = w2cmat.w2c;
    ConversionMat = EllipsoidDicMat.joost2ellipsoid;
    MethodNumber = 2;
  elseif strcmpi(method, 'robert')
    ConfigsMat.ParFileName1 = 'TSE_JOSA_Params1.mat';
    ConfigsMat.ParFileName2 = 'TSE_JOSA_Params2.mat';
    ConfigsMat.ParFileName3 = 'TSE_JOSA_Params3.mat';
    ConversionMat = EllipsoidDicMat.robert2ellipsoid;
    MethodNumber = 3;
  else
    error(['Method ', method, ' is not supported']);
  end
end
method = lower(method);
disp(['Applying method of ', method]);

if MethodNumber ~= 1
  ConfigsMatRgbTitle = load('lab_ellipsoid_params');
else
  ConfigsMatRgbTitle = ConfigsMat;
end
EllipsoidsTitles = ConfigsMatRgbTitle.RGBTitles;
EllipsoidsRGBs = name2rgb(EllipsoidsTitles);

ResultDirectory = [DirPath, method, '_results/'];
if ~isdir(ResultDirectory)
  mkdir(ResultDirectory);
end

ImageFiles = dir([DirPath, '*.jpg']);
nimages = length(ImageFiles);

if EvaluateGroundTruth
  MaskFiles = dir([DirPath, '*.png']);
  if nimages ~= length(MaskFiles)
    warning(['Directory ', DirPath, ' does not have same number of pictures and gts.']);
    EvaluateGroundTruth = false;
  end
end

if EvaluateGroundTruth
  ErrorMats = cell(nimages, 1);
end
for i = 1:nimages
  ImagePath = [DirPath, ImageFiles(i).name];
  ImageRGB = imread(ImagePath);
  disp(ImagePath);
  switch MethodNumber
    case 1
      [NamingImage, BelongingImage] = ColourNamingOur(ImageRGB, ConfigsMat);
    case 2
      [NamingImage, BelongingImage] = ColourNamingJoost(ImageRGB, ConfigsMat, ConversionMat);
    case 3
      [NamingImage, BelongingImage] = ColourNamingRobert(ImageRGB, ConfigsMat, ConversionMat);
  end
  
  % plotting
  figurei = PlotAllChannels(ImageRGB, BelongingImage, EllipsoidsTitles, EllipsoidsRGBs, 'Colour Categorisation - Colour Planes');
  saveas(figurei, [ResultDirectory, 'res_prob', ImageFiles(i).name]);
  close(figurei);
  
  figurei = figure('NumberTitle', 'Off', 'Name', [method, ' Colour Naming'], 'visible', 'off');
  subplot(1, 2, 1);
  imshow(uint8(ImageRGB));
  subplot(1, 2, 2);
  imshow(ColourLabelImage(NamingImage));
  saveas(figurei, [ResultDirectory, 'res_', ImageFiles(i).name]);
  close(figurei);
  
  if EvaluateGroundTruth
    MaskPath = [DirPath, MaskFiles(i).name];
    ImageMask = im2bw(imread(MaskPath));
    ErrorMats{i} = ColourNamingComputeError(ImageMask, NamingImage, GroundTruthColour);
    fprintf('Sensitivity %0.2f Specificity %0.2f Positive predictive %0.2f Negative predictive %0.2f\n', ErrorMats{i}.sens, ErrorMats{i}.spec, ErrorMats{i}.ppv, ErrorMats{i}.npv);
    fprintf('TP %d FP %d TN %d FN %d\n', ErrorMats{i}.tp, ErrorMats{i}.fp, ErrorMats{i}.tn, ErrorMats{i}.fn);
  end
  
end
if EvaluateGroundTruth
  save([ResultDirectory, 'ErrorMats.mat'], 'ErrorMats');
end

end
