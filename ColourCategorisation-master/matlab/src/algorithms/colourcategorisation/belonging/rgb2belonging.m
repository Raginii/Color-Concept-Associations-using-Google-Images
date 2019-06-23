function BelongingImage = rgb2belonging(ImageRGB, ConfigsMat, plotme, GroundTruth, DoAdaptEllipsoids)
%RGB2BELONGING  labels each pixel in the image as one of the focal eleven
%               colours.

if nargin < 2
  ConfigsMat = 'lab';
end
if ischar(ConfigsMat)
  ColourSpace = ConfigsMat;
  ConfigsMat = [];
else
  ColourSpace = lower(ConfigsMat.ColourSpace);
end

if nargin < 4
  plotme = false;
end

if nargin < 5
  DoAdaptEllipsoids = false;
end

if max(ImageRGB(:)) <= 1
  ImageRGB = uint8(ImageRGB .* 255);
end

% TODO: try CMYK as well
if strcmpi(ColourSpace, 'lsy')
  if isempty(ConfigsMat)
    ConfigsMat = load('lsy_ellipsoid_params');
  end
  % TODO: make a more permanent solution, this is just becuase 0 goes to the
  % end of the world (ImageRGB + 1)
  % gammacorrect = true, max pix value > 1, max luminance = daylight
  ImageOpponent = XYZ2lsY(sRGB2XYZ(ImageRGB + 1, true, [10 ^ 2, 10 ^ 2, 10 ^ 2]), 'evenly_ditributed_stds');
  axes = {'l', 's', 'y'};
elseif strcmpi(ColourSpace, 'lab')
  if isempty(ConfigsMat)
    ConfigsMat = load('lab_ellipsoid_params');
  end
  ImageOpponent = double(applycform(ImageRGB, makecform('srgb2lab')));
  axes = {'l', 'a', 'b'};
end
ColourEllipsoids = ConfigsMat.ColourEllipsoids;

if DoAdaptEllipsoids && size(ImageOpponent, 1) * size(ImageOpponent, 2) > 500
  ColourEllipsoids = AdaptEllipsoids(ImageOpponent, ColourEllipsoids);
end

BelongingImage = AllEllipsoidsEvaluateBelonging(ImageOpponent, ColourEllipsoids);

if plotme
  EllipsoidsTitles = ConfigsMat.RGBTitles;
  EllipsoidsRGBs = name2rgb(EllipsoidsTitles);
  % just for debugging purpose for the small images
  PlotAllPixels(ImageRGB, ImageOpponent, ColourEllipsoids, EllipsoidsRGBs, axes, GroundTruth);
  
  PlotAllChannels(ImageRGB, BelongingImage, EllipsoidsTitles, EllipsoidsRGBs, 'Colour Categorisation - Colour Planes');
  if ~isempty(GroundTruth)
    PlotAllChannels(ImageRGB, GroundTruth, EllipsoidsTitles, EllipsoidsRGBs, 'Colour Categorisation - Ground Truth');
  end
end

end

function [] = PlotAllPixels(ImageRGB, ImageOpponent, ColourEllipsoids, EllipsoidsRGBs, axes, GroundTruth)

if isempty(GroundTruth)
  return;
end

LabMin = min(min(ImageOpponent));
LabMax = max(max(ImageOpponent));
LabAvg = mean(mean(ImageOpponent));
LabStd = std(std(ImageOpponent));

[rows, cols, chns] = size(ImageOpponent);
if rows * cols < 500
  nfigures = 3;
else
  nfigures = 3;
  ScaleFactor = 0.1;
  ImageOpponent = imresize(ImageOpponent, ScaleFactor);
  ImageRGB = imresize(ImageRGB, ScaleFactor);
  [rows, cols, chns] = size(ImageOpponent);
end

ImageRGB = im2double(ImageRGB);
ImageRGB = reshape(ImageRGB, rows * cols, chns);
ImageOpponent = reshape(ImageOpponent, rows * cols, chns);

AxesViews = [0, 90; 0, 0; 90, 0;];
figure();
for k = 1:nfigures
  h = subplot(1, nfigures, k);
  hold on;
  grid on;
  scatter3(ImageOpponent(:, 1), ImageOpponent(:, 2), ImageOpponent(:, 3), 36, ImageRGB, '*');
  PlotAllEllipsoids(ColourEllipsoids, EllipsoidsRGBs, h);
  PlotCube(LabMin, LabMax, 'b');
  PlotCube(LabAvg - LabStd, LabAvg + LabStd, 'r')
  xlabel(axes{1});
  ylabel(axes{2});
  zlabel(axes{3});
  view(AxesViews(k, :));
end

end

function [] = PlotCube(pmin, pmax, colour)
plot3...
  (...
  [pmin(1), pmin(1), pmax(1), pmax(1), pmin(1), pmin(1), pmin(1), pmax(1), pmax(1), pmin(1)], ...
  [pmin(2), pmax(2), pmax(2), pmin(2), pmin(2), pmin(2), pmax(2), pmax(2), pmin(2), pmin(2)], ...
  [pmin(3), pmin(3), pmin(3), pmin(3), pmin(3), pmax(3), pmax(3), pmax(3), pmax(3), pmax(3)], ...
  colour ...
  );
plot3([pmin(1), pmin(1)], [pmax(2), pmax(2)], [pmin(3), pmax(3)], colour);
plot3([pmax(1), pmax(1)], [pmin(2), pmin(2)], [pmin(3), pmax(3)], colour);
plot3([pmax(1), pmax(1)], [pmax(2), pmax(2)], [pmin(3), pmax(3)], colour);

pcentre = (pmax + pmin) / 2;
plot3(pcentre(1), pcentre(2), pcentre(3), ['o', colour]);
end

function ColourEllipsoids = AdaptEllipsoids(ImageOpponent, ColourEllipsoids)

% indices of colour ooponency
configs.lumindc = 1;
configs.luminda = 4;
configs.rgindc = 2;
configs.rginda = 5;
configs.ybindc = 3;
configs.ybinda = 6;

% middle point of colour opponency
configs.lumavg = 128;
configs.rgavg = 128;
configs.ybavg = 128;

% maximums and minimums
configs.rgmin = 70;
configs.ybmin = 70;
configs.rgmax = 190;
configs.ybmax = 190;

configs.rgstdtol = 0.025 * configs.rgavg;
configs.ybstdtol = 0.025 * configs.ybavg;

configs.LabMin = min(min(ImageOpponent));
configs.LabMax = max(max(ImageOpponent));
configs.LabAvg = mean(mean(ImageOpponent));
configs.LabStd = std(std(ImageOpponent));

configs.BlackWhitePercent = [0.21; 0.12];

diff = configs.LabAvg - 128;

% FIXME: we should apply each adaptation based on the need
if diff(1) < 11 && diff(2) < 2 && diff(3) < 2 && configs.LabMax(2) < configs.rgmax && configs.LabMax(3) < configs.ybmax && configs.LabMin(2) > configs.rgmin && configs.LabMin(3) > configs.ybmin
  fprintf('Adaptation not necessary\n');
else
  ColourEllipsoids = AdaptEllipsoidsAvgs(ColourEllipsoids, configs);
  ColourEllipsoids = AdaptEllipsoidsMaxs(ColourEllipsoids, configs);
  ColourEllipsoids = AdaptEllipsoidsMins(ColourEllipsoids, configs);
  ColourEllipsoids = AdaptEllipsoidsStds(ColourEllipsoids, configs);
end

end

function ColourEllipsoids = AdaptEllipsoidsMaxs(ColourEllipsoids, configs)

% indices of colour ooponency
lumindc = configs.lumindc;
luminda = configs.luminda;
rgindc = configs.rgindc;
rginda = configs.rginda;
ybindc = configs.ybindc;
ybinda = configs.ybinda;

% maximums and minimums
rgmax = configs.rgmax;
ybmax = configs.ybmax;

LabMax = configs.LabMax;

fprintf('Max-RG\n');
% if maximum value of rg-channel is too low
if LabMax(rgindc) < rgmax
  rgmaxper = 1 - LabMax(rgindc) / rgmax;
  
  % make the achromatic bigger
  ColourInds = 9:11;
  ColourEllipsoids = EnlargePositive(ColourEllipsoids, ColourInds, rgmaxper, rgindc, rginda);
end

fprintf('Max-YB\n');
% if maximum value of yb-channel is too high
if LabMax(ybindc) > ybmax
  ybmaxper = 1 - (ybmax / LabMax(ybindc));
  ColourInds = 1:8;
  diff = ColourEllipsoids(ColourInds, ybinda) .* ybmaxper;
  
  % make chromatic ellipsoids smaller
  %   ColourEllipsoids(ColourInds, ybindc) = ColourEllipsoids(ColourInds, ybindc) + (diff / 2) .* sign(ColourEllipsoids(ColourInds, ybindc));
  ColourEllipsoids(ColourInds, ybinda) = ColourEllipsoids(ColourInds, ybinda) - (diff / 2);
  fprintf('Colour chromatic, channel %d, being shrinked %f per-cent\n', ybindc, ybmaxper);
end

end

function ColourEllipsoids = AdaptEllipsoidsMins(ColourEllipsoids, configs)

% indices of colour ooponency
lumindc = configs.lumindc;
luminda = configs.luminda;
rgindc = configs.rgindc;
rginda = configs.rginda;
ybindc = configs.ybindc;
ybinda = configs.ybinda;

% maximums and minimums
rgmin = configs.rgmin;
ybmin = configs.ybmin;

LabMin = configs.LabMin;

fprintf('Min-RG\n');
% if minimum value of rg-channel is too high
if LabMin(rgindc) > rgmin
  rgminper = rgmin / LabMin(rgindc);
  ColourInds = 9:11;
  ColourEllipsoids = EnlargePositive(ColourEllipsoids, ColourInds, rgminper, rgindc, rginda);
end

fprintf('Min-YB\n');
% if minimum value of yb-channel is too high
if LabMin(ybindc) > ybmin
  ybminper = ybmin / LabMin(ybindc);
  ColourInds = 9:11;
  ColourEllipsoids = EnlargePositive(ColourEllipsoids, ColourInds, ybminper, ybindc, ybinda);
end

end

function ColourEllipsoids = AdaptEllipsoidsStds(ColourEllipsoids, configs)

% indices of colour ooponency
lumindc = configs.lumindc;
luminda = configs.luminda;
rgindc = configs.rgindc;
rginda = configs.rginda;
ybindc = configs.ybindc;
ybinda = configs.ybinda;

% middle point of colour opponency
lumavg = configs.lumavg;

LabAvg = configs.LabAvg;
LabStd = configs.LabStd;

rgstdtol = configs.rgstdtol;
ybstdtol = configs.ybstdtol;

% if there is more than 0.10 per cent deviation in luminance
lumstddiff = abs(LabStd(lumindc) - 0.1 * lumavg);
if lumstddiff > 1
  lumstdper = lumstddiff / (0.025 * lumavg);
  % only allowing 100 per-cent
  lumstdper = min(1, lumstdper);
  
  % make achromatics larger
  if LabAvg(lumindc) > (lumavg + 0.25 * lumavg)
    ColourInds = [9, 11];
    diff = ColourEllipsoids(ColourInds, [rginda, ybinda]) .* lumstdper;
    % grey is enlargened half of black and white
    diff(1, :) = diff(1, :) * 0.33;
    diff = diff/ 2;
    ColourEllipsoids(ColourInds, [rginda, ybinda]) = ColourEllipsoids(ColourInds, [rginda, ybinda]) + diff;
  elseif LabAvg(lumindc) < (lumavg - 0.25 * lumavg)
    ColourInds = [9, 10];
    diff = ColourEllipsoids(ColourInds, [rginda, ybinda]) .* lumstdper;
    % grey is enlargened half of black and white
    diff(1, :) = diff(1, :) * 0.33;
    diff = diff/ 2;
    ColourEllipsoids(ColourInds, [rginda, ybinda]) = ColourEllipsoids(ColourInds, [rginda, ybinda]) + diff;
  else
    ColourInds = [10, 11];
    diff = ColourEllipsoids(ColourInds, [rginda, ybinda]) .* lumstdper;
    diff = diff/ 2;
    ColourEllipsoids(ColourInds, [rginda, ybinda]) = ColourEllipsoids(ColourInds, [rginda, ybinda]) + diff;
  end
  fprintf('STD-Lum - Colour %d %d, channel %d, being streched %f per-cent\n', ColourInds, rgindc, lumstdper);
  fprintf('STD-Lum - Colour %d %d, channel %d, being streched %f per-cent\n', ColourInds, ybindc, lumstdper);
end

% if there is more than 0.025 per cent deviation in rg-channel
rgstddiff = abs(LabStd(rgindc) - rgstdtol);
if rgstddiff > 1
  fprintf('STD-RG\n');
  GreenSmallerPercent = max((1 / rgstddiff), 0.65);
  ColourInds = 1;
  ColourEllipsoids(ColourInds, ybinda) = ColourEllipsoids(ColourInds, ybinda) * GreenSmallerPercent;
  fprintf('Colour %d, channel %d, being shrinked to %f per-cent\n', ColourInds, ybindc, GreenSmallerPercent);
  
  ColourInds = 9:11;
  rgstdper = rgstddiff / rgstdtol;
  diff = ColourEllipsoids(ColourInds, rginda) .* rgstdper;
  diff(1, :) = diff(1, :) * 0.5;
  ColourEllipsoids(ColourInds, rginda) = ColourEllipsoids(ColourInds, rginda) + diff;
  fprintf('Colour %d %d %d, channel %d, being streched %f per-cent\n', ColourInds, rgindc, rgstdper);
end

% if there is more than 0.025 per cent deviation in yb-channel
ybstddiff = abs(LabStd(ybindc) - ybstdtol);
if ybstddiff > 1
  fprintf('STD-YB\n');
  %   ColourEllipsoids(2, luminda) = ColourEllipsoids(2, luminda) / ybstddiff;
  ColourInds = 9:11;
  ybstdper = ybstddiff / ybstdtol;
  diff = ColourEllipsoids(ColourInds, ybinda) .* ybstdper;
  diff(1, :) = diff(1, :) * 0.5;
  ColourEllipsoids(ColourInds, ybinda) = ColourEllipsoids(ColourInds, ybinda) + diff;
  fprintf('Colour %d %d %d, channel %d, being streched %f per-cent\n', ColourInds, ybindc, ybstdper);
end

end

function ColourEllipsoids = AdaptEllipsoidsAvgs(ColourEllipsoids, configs)

% indices of colour ooponency
lumindc = configs.lumindc;
luminda = configs.luminda;
rgindc = configs.rgindc;
rginda = configs.rginda;
ybindc = configs.ybindc;
ybinda = configs.ybinda;

% middle point of colour opponency
lumavg = configs.lumavg;
rgavg = configs.rgavg;
ybavg = configs.ybavg;

LabAvg = configs.LabAvg;
LabStd = configs.LabStd;

% too dark
if LabAvg(lumindc) < lumavg
  diff = abs(lumavg - LabAvg(lumindc));
  ColourInds = 1;
  ColourEllipsoids(ColourInds, lumindc) = ColourEllipsoids(ColourInds, lumindc) - (diff / 2);
  ColourEllipsoids(ColourInds, luminda) = ColourEllipsoids(ColourInds, luminda) - (diff / 2);
  fprintf('AVG-Lum - Colour %d, channel %d, being shrinked on POS %f\n', ColourInds, lumindc, diff);
  
  ColourInds = 7;
  YellowBiggerPercent = LabAvg(lumindc) / lumavg;
  diff = ColourEllipsoids(ColourInds, rginda) * YellowBiggerPercent;
  ColourEllipsoids(ColourInds, rgindc) = ColourEllipsoids(ColourInds, rgindc) - (diff / 2);
  ColourEllipsoids(ColourInds, rginda) = ColourEllipsoids(ColourInds, rginda) + (diff / 2);
  fprintf('AVG-Lum - Colour %d, channel %d, being streched on NEG %f per-cent\n', ColourInds, rgindc, YellowBiggerPercent);
  
  ColourInds = 4;
  PinkSmallerPercent = LabAvg(lumindc) / lumavg;
  ColourEllipsoids(ColourInds, luminda) = ColourEllipsoids(ColourInds, luminda) * PinkSmallerPercent;
  fprintf('AVG-Lum - Colour %d, channel %d, being shrinked %f per-cent\n', ColourInds, lumindc, PinkSmallerPercent);
end

fprintf('AVG-RG\n');
% too much green
if LabAvg(rgindc) < rgavg
  rgdiff = rgavg - LabAvg(rgindc);
  
  % make the achromatic bigger
  ColourInds = 9:11;
  EnlargeScale = abs(rgdiff) / rgavg;
  ColourEllipsoids = EnlargeNegative(ColourEllipsoids, ColourInds, EnlargeScale, rgindc, rginda);
end
% too much red
if LabAvg(rgindc) > rgavg
  rgdiff = rgavg - LabAvg(rgindc);
  
  % make the achromatic bigger
  ColourInds = 9:11;
  EnlargeScale = abs(rgdiff) / rgavg;
  ColourEllipsoids = EnlargePositive(ColourEllipsoids, ColourInds, EnlargeScale, rgindc, rginda);
end

fprintf('AVG-YB\n');
% too much yellow
if LabAvg(ybindc) > ybavg
  ybdiff = ybavg - LabAvg(ybindc);
  
  % too bright
  if LabAvg(lumindc) > (lumavg + 0.25 * lumavg)
    % shrinks the blue
    ColourInds = 2;
    ShrinkScale = 2 * abs(ybdiff) / ybavg;
    ColourEllipsoids = ShrinkPositive(ColourEllipsoids, ColourInds, ShrinkScale, ybindc, ybinda);
  end
  
  % make the achromatic bigger
  ColourInds = 9:11;
  EnlargeScale = -ybdiff / 8;
  ColourEllipsoids = EnlargeNegative(ColourEllipsoids, ColourInds, EnlargeScale, ybindc, ybinda);
end

for ColourInds = 9:11
  % FIXME: something better set a maximum per cent
  %   ColourEllipsoids = CoverAvgStd(ColourEllipsoids, ColourInds, LabAvg, LabStd, rgindc, rginda);
  %   ColourEllipsoids = CoverAvgStd(ColourEllipsoids, ColourInds, LabAvg, LabStd, ybindc, ybinda);
end

end

function ColourEllipsoids = CoverAvgStd(ColourEllipsoids, ColourInds, LabAvg, LabStd, indc, inda)

poslim = ColourEllipsoids(ColourInds, indc) + ColourEllipsoids(ColourInds, inda);

if poslim < LabAvg(indc) + LabStd(indc)
  diff = abs(poslim - LabAvg(indc) - LabStd(indc));
  ColourEllipsoids(ColourInds, indc) = ColourEllipsoids(ColourInds, indc) + (diff / 2);
  ColourEllipsoids(ColourInds, inda) = ColourEllipsoids(ColourInds, inda) + (diff / 2);
  fprintf('AVG-STD - Colour %d, channel %d, being streched on POS %f\n', ColourInds, indc, diff);
end

neglim = ColourEllipsoids(ColourInds, indc) - ColourEllipsoids(ColourInds, inda);
if neglim > LabAvg(indc) - LabStd(indc)
  diff = abs(neglim - LabAvg(indc) - LabStd(indc));
  ColourEllipsoids(ColourInds, indc) = ColourEllipsoids(ColourInds, indc) - (diff / 2);
  ColourEllipsoids(ColourInds, inda) = ColourEllipsoids(ColourInds, inda) + (diff / 2);
  fprintf('AVG-STD - Colour %d, channel %d, being streched on NEG %f\n', ColourInds, indc, diff);
end

end

function ColourEllipsoids = EnlargePositive(ColourEllipsoids, ColourInds, EnlargeScale, indc, inda)

diff = ColourEllipsoids(ColourInds, inda) * EnlargeScale;

ColourEllipsoids(ColourInds, indc) = ColourEllipsoids(ColourInds, indc) + (diff / 2);
ColourEllipsoids(ColourInds, inda) = ColourEllipsoids(ColourInds, inda) + (diff / 2);

WhichColours = '';
for i = 1:length(ColourInds)
  WhichColours = [WhichColours, '%d ']; %#ok
end
fprintf(['Colour ', WhichColours, ', channel %d, being streched on POS %f per-cent\n'], ColourInds, indc, EnlargeScale);

end

function ColourEllipsoids = EnlargeNegative(ColourEllipsoids, ColourInds, EnlargeScale, indc, inda)

diff = ColourEllipsoids(ColourInds, inda) * EnlargeScale;

ColourEllipsoids(ColourInds, indc) = ColourEllipsoids(ColourInds, indc) - (diff / 2);
ColourEllipsoids(ColourInds, inda) = ColourEllipsoids(ColourInds, inda) + (diff / 2);

WhichColours = '';
for i = 1:length(ColourInds)
  WhichColours = [WhichColours, '%d ']; %#ok
end
fprintf(['Colour ', WhichColours, ', channel %d, being streched on NEG %f per-cent\n'], ColourInds, indc, EnlargeScale);

end

function ColourEllipsoids = ShrinkPositive(ColourEllipsoids, ColourInds, EnlargeScale, indc, inda)

diff = ColourEllipsoids(ColourInds, inda) * EnlargeScale;

ColourEllipsoids(ColourInds, indc) = ColourEllipsoids(ColourInds, indc) - (diff / 2);
ColourEllipsoids(ColourInds, inda) = ColourEllipsoids(ColourInds, inda) - (diff / 2);

WhichColours = '';
for i = 1:length(ColourInds)
  WhichColours = [WhichColours, '%d ']; %#ok
end
fprintf(['Colour ', WhichColours, ', channel %d, being shrinked on POS %f per-cent\n'], ColourInds, indc, EnlargeScale);

end

function ColourEllipsoids = ShrinkNegative(ColourEllipsoids, ColourInds, EnlargeScale, indc, inda)

diff = ColourEllipsoids(ColourInds, inda) * EnlargeScale;

ColourEllipsoids(ColourInds, indc) = ColourEllipsoids(ColourInds, indc) + (diff / 2);
ColourEllipsoids(ColourInds, inda) = ColourEllipsoids(ColourInds, inda) - (diff / 2);

WhichColours = '';
for i = 1:length(ColourInds)
  WhichColours = [WhichColours, '%d ']; %#ok
end
fprintf(['Colour ', WhichColours, ', channel %d, being shrinked on NEG %f per-cent\n'], ColourInds, indc, EnlargeScale);

end
