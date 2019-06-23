function ColourEllipsoids = FitExperimentPointsToEllipsoid(WhichColours, plotme, saveme)

if nargin < 1
  WhichColours = {'c'};
end
if nargin < 2
  plotme = 1;
  saveme = 1;
end

if strcmpi(WhichColours{1}, 'c')
  WhichColours = {'G', 'B', 'Pp', 'Pk', 'R', 'O', 'Y', 'Br'};
elseif strcmpi(WhichColours{1}, 'a')
  WhichColours = {'G', 'B', 'Pp', 'Pk', 'R', 'O', 'Y', 'Br', 'Gr', 'W', 'Bl'};
end

R  = [1.0, 0.0, 0.0];
G  = [0.0, 1.0, 0.0];
B  = [0.0, 0.0, 1.0];
Y  = [1.0, 1.0, 0.0];
Pp = [0.7, 0.0, 0.7];
O  = [1.0, 0.5, 0.0];
Pk = [1.0, 0.0, 1.0];
Br = [1.0, 0.5, 0.0] * 0.75;
W  = [1.0, 1.0, 1.0];
Gr = [0.5, 0.5, 0.5];
Bl = [0.0, 0.0, 0.0];

% ColourFrontiers = OrganiseExperimentFrontiers('rawdata_Lab.mat');
ColourFrontiersMat = load('ColourFrontierPointsLsy');
ColourFrontiers = ColourFrontiersMat.ColourFrontiers;

WhichColours = lower(WhichColours);
ncolours = length(WhichColours);
ellipses = zeros(11, 9);
RSSes = zeros(11, 2);

% for testing only one colour
GoodResult = load('lsy_ellipsoid_params_new.mat');
ellipses(:, 1:9) = GoodResult.ColourEllipsoids(:, 1:9);
% TODO: instead of RSSes put the steepness
RSSes(:, 2) = GoodResult.ColourEllipsoids(:, 10);

tested = [];
if plotme
  figure;
end

FittingData = struct();

%========================= generate results ================================
for pp = 1:ncolours
  switch WhichColours{pp}
    case {'g', 'green'}
      FittingData.category = 'green';
      FittingParams = ColourEllipsoidFittingParams(ColourFrontiers.(FittingData.category));
      FittingParams.EstimatedAxes = [0.08, 0.12, 100];
      FittingParams.EstimatedCentre = [0.59, 0.01, 0];
      FittingParams.EstimatedAngles = deg2rad([1, 1, 83]);
      
      borders = [36, 47, 58, 76, 81, 86];
      [ellipses(1, :), RSSes(1, :)] = DoColour(FittingParams, FittingData, borders, plotme, []);
      tested = [tested, 1];
    case {'b', 'blue'}
      FittingData.category = 'blue';
      FittingParams = ColourEllipsoidFittingParams(ColourFrontiers.(FittingData.category));
      FittingParams.EstimatedAxes = [0.08, 0.22, 100];
      FittingParams.EstimatedCentre = [0.58, 0.23, 37];
      FittingParams.EstimatedAngles = deg2rad([3, 0, 20]);
      
      borders = [36, 47, 58, 76, 81, 86];
      [ellipses(2, :), RSSes(2, :)] = DoColour(FittingParams, FittingData, borders, plotme, []);
      tested = [tested, 2];
    case {'pp', 'purple'}
      FittingData.category = 'purple';
      FittingParams = ColourEllipsoidFittingParams(ColourFrontiers.(FittingData.category));
      FittingParams.EstimatedAxes = [0.11, 0.20, 76];
      FittingParams.EstimatedCentre = [0.75, 0.25, 0.19];
      FittingParams.EstimatedAngles = deg2rad([2, 2, 330]);
      
      borders = [36, 47, 58, 76];
      [ellipses(3, :), RSSes(3, :)] = DoColour(FittingParams, FittingData, borders, plotme, []);
      tested = [tested, 3];
    case {'pk', 'pink'}
      FittingData.category = 'pink';
      FittingParams = ColourEllipsoidFittingParams(ColourFrontiers.(FittingData.category));
      FittingParams.EstimatedAxes = [0.06, 0.05, 51];
      FittingParams.EstimatedCentre = [0.76, 0.09, 70];
      FittingParams.EstimatedAngles = deg2rad([0, 0, 0]);
      
      borders = [58, 76, 81, 86];
      [ellipses(4, :), RSSes(4, :)] = DoColour(FittingParams, FittingData, borders, plotme, []);
      tested = [tested, 4];
    case {'r', 'red'}
      FittingData.category = 'red';
      FittingParams = ColourEllipsoidFittingParams(ColourFrontiers.(FittingData.category));
      FittingParams.EstimatedAxes = [0.09, 0.04, 40];
      FittingParams.EstimatedCentre = [0.88, 0.02, 0.00];
      FittingParams.EstimatedAngles = deg2rad([0, 0, 165]);
      
      borders = [36, 47, 58];
      [ellipses(5, :), RSSes(5, :)] = DoColour(FittingParams, FittingData, borders, plotme, []);
      tested = [tested, 5];
    case {'o', 'orange'}
      FittingData.category = 'orange';
      FittingParams = ColourEllipsoidFittingParams(ColourFrontiers.(FittingData.category));
      FittingParams.EstimatedAxes = [0.02, 0.06, 50];
      FittingParams.EstimatedCentre = [0.69, 0.02, 50];
      FittingParams.EstimatedAngles = deg2rad([0, 0, 66]);
      
      borders = [58, 76, 81, 86];
      [ellipses(6, :), RSSes(6, :)] = DoColour(FittingParams, FittingData, borders, plotme, []);
      tested = [tested, 6];
    case {'y', 'yellow'}
      FittingData.category = 'yellow';
      FittingParams = ColourEllipsoidFittingParams(ColourFrontiers.(FittingData.category));
      FittingParams.EstimatedAxes = [0.02, 0.04, 75];
      FittingParams.EstimatedCentre = [0.68, 0.01, 75];
      FittingParams.EstimatedAngles = deg2rad([0, 0, 25]);
      
      borders = [58, 76, 81, 86];
      [ellipses(7, :), RSSes(7, :)] = DoColour(FittingParams, FittingData, borders, plotme, []);
      tested = [tested, 7];
    case {'br', 'brown'}
      FittingData.category = 'brown';
      FittingParams = ColourEllipsoidFittingParams(ColourFrontiers.(FittingData.category));
      FittingParams.EstimatedAxes = [0.0246, 0.0512, 40];
      FittingParams.EstimatedCentre = [0.73, 0.02, 0.00];
      FittingParams.EstimatedAngles = deg2rad([0, 0, 57]);
      
      borders = [36, 47, 58];
      [ellipses(8, :), RSSes(8, :)] = DoColour(FittingParams, FittingData, borders, plotme, []);
      tested = [tested, 8];
    case {'gr', 'grey'}
      FittingData.category = 'grey';
      FittingParams = ColourEllipsoidFittingParams(ColourFrontiers.(FittingData.category));
      FittingParams.EstimatedAxes = [0.01, 0.01, 35];
      FittingParams.EstimatedCentre = [0.650, 0.064, 42];
      FittingParams.EstimatedAngles = deg2rad([0, 0, 0]);
      
      borders = [36, 47, 58, 76, 81, 86];
      [ellipses(9, :), RSSes(9, :)] = DoColour(FittingParams, FittingData, borders, plotme, []);
      ellipses(10, :) = ellipses(9, :);
      ellipses(10, 3) = 90;
      ellipses(10, 4:5) = ellipses(10, 4:5) ./ 2;
      ellipses(10, 6) = 25;
      ellipses(11, :) = ellipses(9, :);
      ellipses(11, 3) = 0;
      ellipses(11, 6) = 15;
      ellipses(11, 4:5) = ellipses(11, 4:5) ./ 2;
      tested = [tested, 9, 10, 11]; %#ok<*AGROW>
    case {'w', 'white'}
      %       FittingData.category = 'white';
      %       points = lsYFrontiers.(FittingData.category).GetAllBorders();
      %       ellipses(10, :) = [mean(points), 0.1, 0.1, std(points(:, 3)), 0, 0, 0];
      %       RSSes(10, :) = norm(DistanceEllipsoid(points, ellipses(10, :)), 'fro') .^ 2;
      %       tested = [tested, 10]; %#ok<*AGROW>
    case {'bl', 'black'}
      %       FittingData.category = 'black';
      %       points = lsYFrontiers.(FittingData.category).GetAllBorders();
      %       ellipses(11, :) = [mean(points), 0.1, 0.1, std(points(:, 3)), 0, 0, 0];
      %       RSSes(11, :) = norm(DistanceEllipsoid(points, ellipses(11, :)), 'fro') .^ 2;
      %       tested = [tested, 11]; %#ok<*AGROW>
    otherwise
      disp('Wrong category, quitting...');
      return;
  end
end

RSSes(1:8, 2) = 0;
RSSes(9:11, 2) = 0;
ColourEllipsoids = [ellipses, RSSes(:, 2)];

if saveme
  RGBTitles = {'G', 'B', 'Pp', 'Pk', 'R', 'O', 'Y', 'Br', 'Gr', 'W', 'Bl'}; %#ok
  save('lsy_ellipsoid_params_new.mat', 'ColourEllipsoids', 'RGBTitles');
end

if plotme
  RGB = [G; B; Pp; Pk; R; O; Y; Br; Gr; W; Bl];
  PlotEllipsoids(ellipses, RGB, tested, WhichColours);
end

end

function [ellipsoid, RSS] = DoColour(FittingParams, FittingData, borders, plotme, initial)

% D65 XYZ cordinates calculated according to the CIE Judd-Vos corrected
% Colour Matching Functions
JV_D65 = [116.5366244	124.6721208	125.456254];
FittingData.borders = [];
for i = borders
  levelsXYZ = Lab2XYZ([i, 0, 0], JV_D65);
  FittingData.(['data', num2str(i)]) = FittingParams.colour.GetBorder(i);
  FittingData.(['ylevel', num2str(i)]) = levelsXYZ;
  FittingData.borders = [FittingData.borders; FittingData.(['data', num2str(i)])];
end

if plotme
  if ~isempty(FittingData.borders)
    plot3(FittingData.borders(:, 1), FittingData.borders(:, 2), FittingData.borders(:, 3), '.', 'Color', FittingParams.colour.rgb);
    hold on;
  end
end

FittingData.allstd = std(FittingData.borders);
FittingData.allmeans = mean(FittingData.borders);

if isempty(initial)
  FittingParams.EstimatedCentre(1:2) = FittingParams.EstimatedCentre(1:2) * 100;
  FittingParams.EstimatedAxes(1:2) = FittingParams.EstimatedAxes(1:2) * 100;
  initial = [FittingParams.EstimatedCentre, FittingParams.EstimatedAxes, FittingParams.EstimatedAngles];
end
RSS(1) = ColourEllipsoidFitting(initial, FittingData);
FittingParams.MinCentre = initial(1:3) - 0.05 .* initial(1:3);
FittingParams.MaxCentre = initial(1:3) + 0.05 .* initial(1:3);
FittingParams.MinAxes = initial(4:6) .* 0.9;
FittingParams.MaxAxes = initial(4:6) .* 1.1;
FittingParams.MinAngle = initial(7:9) .* 0.9;
FittingParams.MaxAngle = initial(7:9) .* 1.1;
lb = ...
  [
  FittingParams.MinCentre, FittingParams.MinAxes, FittingParams.MinAngle
%   FittingParams.MinCentre(1:2), 0, FittingParams.MinAxes(1:2), 0, 0, 0, 0
%   0, 0, 0, 0, 0, 0, 0, 0, 0
  ];
ub = ...
  [
  FittingParams.MaxCentre, FittingParams.MaxAxes, FittingParams.MaxAngle
%   FittingParams.MaxCentre(1:2), inf, FittingParams.MaxAxes(1:2), inf, 2 * pi, 2 * pi, 2 * pi
%   100, 100, 100, 100, 100, 100, 2 * pi, 2 * pi, 2 * pi
  ];
options = optimoptions(@fmincon,'Algorithm', 'sqp', 'Display', 'off', 'MaxIter', 1e6, 'TolFun', 1e-10, 'MaxFunEvals', 1e6);
[ellipsoid, RSS(2), exitflag, output] = fmincon(@(x) ColourEllipsoidFitting(x, FittingData), initial, [], [], [], [], lb, ub, [], options);

disp ('================================================================');
disp (['         Colour category: ', FittingData.category]);
disp ('================================================================');
PrintFittingResults(output, ellipsoid, RSS, exitflag, FittingData.allstd);

end

function PlotEllipsoids(ellipses, RGB, tested, WhichColours)

for i = tested
  DrawEllipsoid(ellipses(i, :), 'FaceColor', [1, 1, 1], 'EdgeColor', RGB(i, :), 'FaceAlpha', 0.3);
  hold on;
end

if length(WhichColours) == 9
  cateq = 'all categories';
else
  cateq = [];
  for pq = 1:length(WhichColours)
    switch WhichColours{pq}
      case {'g', 'green'}
        cateq = [cateq, 'green, '];
      case {'b', 'blue'}
        cateq = [cateq, 'blue, '];
      case {'pp', 'purple'}
        cateq = [cateq, 'purple, '];
      case {'pk', 'pink'}
        cateq = [cateq, 'pink, '];
      case {'r', 'red'}
        cateq = [cateq, 'red, '];
      case {'o', 'orange'}
        cateq = [cateq, 'orange, '];
      case {'y', 'yellow'}
        cateq = [cateq, 'yellow, '];
      case {'br', 'brown'}
        cateq = [cateq, 'brown, '];
      case {'gr', 'grey'}
        cateq = [cateq, 'grey, '];
      case {'w', 'white'}
        cateq = [cateq, 'white, '];
      case {'bl', 'black'}
        cateq = [cateq, 'black, '];
    end
  end
  cateq(size(cateq, 2)) = '';
  cateq(size(cateq, 2)) = '';
end

title(['Category boundaries (', cateq, ') - best elipsod fits']);
xlabel('l');
ylabel('s');
zlabel('Y');
view(-19, 54);
grid on;
set(gcf, 'color', [1, 1, 1]);
hold off;

end

function RSS = ColourEllipsoidFitting(x, FittingData)
% Describe the function
% This function does the actual fitting of the three level datapoints
% obtained by variables data36 data58 and data81 and the 3D-ellipsoid.
% The datapoints correspond to the psychophysical results obtained through
% colour categorization experiments in the frontiers between colour names.
% The ellipsoid parameters are passed to the funtion though the variable x
% which contains the centre and the semi-axes of the 3D-ellipsoid to fit to
% the data. Imagine the ellipsoid as a rugby ball placed with its main axis
% vertically. It intersects the three horizontal dataplanes (at three
% luminance levels) forming three horizontal ellipses.
% The actual fitting is done considering the distance between each
% point in the luminance data plane and the closest point on the ellipse
% for each plane. The output of this function is the residual
% sum of squares (RSS) of these distances, added for the three planes.
% Since the data in the lowest luminance plane has the largest variance, it
% tends to bias the fitting. To counter this, we weighted the RSS
% corresponding to each luminance plane.

if ~isempty(FittingData.borders)
  distances = DistanceEllipsoid(FittingData.borders, x, 0);
  %  The Frobenius norm, sometimes also called the Euclidean norm (which may
  %  cause confusion with the vector L^2-norm which also sometimes known as
  %  the Euclidean norm), is matrix norm of an min matrix  A defined as the
  %  square root of the sum of the absolute squares of its elements
  %   RSS = norm(distances, 'fro');
  RSS = mean(distances);
else
  RSS = 0;
end

end
