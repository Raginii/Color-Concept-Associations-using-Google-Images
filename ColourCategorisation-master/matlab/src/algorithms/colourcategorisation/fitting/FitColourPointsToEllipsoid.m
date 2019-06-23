function ColourEllipsoids = FitColourPointsToEllipsoid(ColourSpace, WhichColours, plotme, saveme)
%FitColourPointsToEllipsoid Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1
  ColourSpace = 'lab';
end
if nargin < 2
  WhichColours = {'a'};
end
if nargin < 3
  plotme = 0;
  saveme = 1;
end
ColourSpace = lower(ColourSpace);

if strcmpi(WhichColours{1}, 'c')
  WhichColours = {'G', 'B', 'Pp', 'Pk', 'R', 'O', 'Y', 'Br'};
elseif strcmpi(WhichColours{1}, 'a')
  WhichColours = {'G', 'B', 'Pp', 'Pk', 'R', 'O', 'Y', 'Br', 'Gr', 'W', 'Bl'};
end

WhichColours = lower(WhichColours);
ncolours = length(WhichColours);
ColourEllipsoids = zeros(11, 10);

% WcsColourTable = WcsChart();
% GroundTruth = WcsResults({'joost', 'robert'}); % , 'sturges', 'berlin'
% % this is to fix the bug of robert's method
% GroundTruth(2, 30, 10) = 0.09;
% ArashTable = ArashColourBoundries();
% % this is to underestimation of the achromatic in the joost't method
% GroundTruth([1, 10], 1:41, 9:11) = ArashTable([1, 10], 1:41, 9:11);
% GroundTruth(:, 1, 9:11) = ArashTable(:, 1, 9:11);
% GroundTruth(2:9, 2:41, 9:11) = GroundTruth(2:9, 2:41, 9:11) / 2;

% I get good result with RSS = sum(sum(abs(GroundTruth - belonging)));
% [WcsColourTable, GroundTruth] = ColourBoxes();

% [WcsColourTable, GroundTruth] = ColourPerception();

% [WcsColourTable, GroundTruth] = SatfacesColourCube();

% [WcsColourTable, GroundTruth] = ColourMembershipExperiment();

% [WcsColourTable, GroundTruth] = SegmentedColourPoints('SegmentedColourPoints.mat');
load('SegmentedColourProbabilities255Averaged.mat');

% PlotAllChannels(WcsColourTable, GroundTruth);

% this allows us to only test one colour, the rest of the colour get the
% latest ellipsoid parameters.
if strcmpi(ColourSpace, 'lsy')
  ColourPoints = XYZ2lsY(sRGB2XYZ(WcsColourTable + 1, true, [10 ^ 2, 10 ^ 2, 10 ^ 2]), 'evenly_ditributed_stds');
  GoodResult = load('lsy_ellipsoid_params.mat');
elseif strcmpi(ColourSpace, 'lab')
  ColourPoints = double(applycform(WcsColourTable, makecform('srgb2lab')));
  GoodResult = load('lab_ellipsoid_params.mat');
end
ColourEllipsoids(:, 1:10) = GoodResult.ColourEllipsoids(:, 1:10);

if plotme
  figure;
  grid on;
  hold on;
end

for i = 1:ncolours
  switch WhichColours{i}
    case {'g', 'green'}
      ColourEllipsoids(1, :) = DoColour(GroundTruth, ColourPoints, 1, 'green', plotme);
    case {'b', 'blue'}
      ColourEllipsoids(2, :) = DoColour(GroundTruth, ColourPoints, 2, 'blue', plotme);
    case {'pp', 'purple'}
      ColourEllipsoids(3, :) = DoColour(GroundTruth, ColourPoints, 3, 'purple', plotme);
    case {'pk', 'pink'}
      ColourEllipsoids(4, :) = DoColour(GroundTruth, ColourPoints, 4, 'pink', plotme);
    case {'r', 'red'}
      ColourEllipsoids(5, :) = DoColour(GroundTruth, ColourPoints, 5, 'red', plotme);
    case {'o', 'orange'}
      ColourEllipsoids(6, :) = DoColour(GroundTruth, ColourPoints, 6, 'orange', plotme);
    case {'y', 'yellow'}
      ColourEllipsoids(7, :) = DoColour(GroundTruth, ColourPoints, 7, 'yellow', plotme);
    case {'br', 'brown'}
      ColourEllipsoids(8, :) = DoColour(GroundTruth, ColourPoints, 8, 'brown', plotme);
    case {'gr', 'grey'}
      ColourEllipsoids(9, :) = DoColour(GroundTruth, ColourPoints, 9, 'grey', plotme);
    case {'w', 'white'}
      ColourEllipsoids(10, :) = DoColour(GroundTruth, ColourPoints, 10, 'white', plotme);
    case {'bl', 'black'}
      ColourEllipsoids(11, :) = DoColour(GroundTruth, ColourPoints, 11, 'black', plotme);
    otherwise
      disp('Wrong category, returning the latest ellipsoid parameters.');
  end
end

if saveme
  RGBTitles = {'G', 'B', 'Pp', 'Pk', 'R', 'O', 'Y', 'Br', 'Gr', 'W', 'Bl'}; %#ok
  save([ColourSpace, '_ellipsoid_params_new.mat'], 'ColourEllipsoids', 'RGBTitles');
end

end

function ColourEllipsoid = DoColour(GroundTruth, ColourPoints, ColourIndex, ColourName, plotme)

% the initial guess with points more probale than 50%
inds = GroundTruth(:, :, ColourIndex) > 0.5;
inds(:, :, 2) = inds(:, :, 1);
inds(:, :, 3) = inds(:, :, 1);

PositivePoints = ColourPoints(inds);
PositivePoints = reshape(PositivePoints, size(PositivePoints, 1) / 3, 3);

if plotme
  if ~isempty(PositivePoints)
    plot3(PositivePoints(:, 1), PositivePoints(:, 2), PositivePoints(:, 3), '.', 'Color', name2rgb(ColourName));
  end
end

if size(PositivePoints, 1) > 1
  initial = [mean(PositivePoints), std(PositivePoints), 0, 0, 0, 1];
  %   initial = [115, 138, 133, std(PositivePoints), 0, 0, 0];
else
  initial = [PositivePoints, 10, 10, 10, 0, 0, 0, 1];
end
lb = ...
  [
  -inf, -inf, -inf, 0.01, 0.01, 0.01, 0, 0, 0, 0.01;
  ];
ub = ...
  [
  inf, inf, inf, inf, inf, inf, pi, pi, pi, inf;
  ];
options = optimoptions(@fmincon,'Algorithm', 'sqp', 'Display', 'off', 'MaxIter', 1e6, 'TolFun', 1e-10, 'MaxFunEvals', 1e6);

% RSS(1) = ColourEllipsoidFittingPoints(initial, PositivePoints);
% [ColourEllipsoid, RSS(2), exitflag, output] = fmincon(@(x) ColourEllipsoidFittingPoints(x, PositivePoints), initial, [], [], [], [], lb, ub, [], options);

RSS(1) = ColourEllipsoidFittingBelonging(initial, ColourPoints, GroundTruth(:, :, ColourIndex));
[ColourEllipsoid, RSS(2), exitflag, output] = fmincon(@(x) ColourEllipsoidFittingBelonging(x, ColourPoints, GroundTruth(:, :, ColourIndex)), initial, [], [], [], [], lb, ub, [], options);

disp ('================================================================');
disp (['         Colour category: ', ColourName]);
disp ('================================================================');
PrintFittingResults(output, ColourEllipsoid, RSS, exitflag, initial(4:6));

if plotme
  DrawEllipsoid(ColourEllipsoid, 'FaceColor', [1, 1, 1], 'EdgeColor', name2rgb(ColourName), 'FaceAlpha', 0.5);
end

end

function RSS = ColourEllipsoidFittingPoints(x, ColourPoints)

if ~isempty(ColourPoints)
  distances = DistanceEllipsoid(ColourPoints, x, 0);
  RSS = mean(distances);
else
  RSS = 0;
end

end

function RSS = ColourEllipsoidFittingBelonging(x, ColourPoints, GroundTruth)

if ~isempty(ColourPoints)
  [belonging, ~] = EllipsoidEvaluateBelonging(ColourPoints, x);
  
  %     PositiveIndeces = GroundTruth == 1;
  %     PosDiff = 1 - belonging(PositiveIndeces);
  %     PosDiff(PosDiff < 0.5) = 0;
  %
  %     NegativeIndeces = GroundTruth == 0;
  %     NegDiff = belonging(NegativeIndeces);
  %     NegDiff(NegDiff < 0.1) = 0;
  %
  %     RSS = sum(PosDiff) + sum(NegDiff);
  
  RSS = sum(sum(abs(GroundTruth - belonging)));
else
  RSS = 0;
end

end
