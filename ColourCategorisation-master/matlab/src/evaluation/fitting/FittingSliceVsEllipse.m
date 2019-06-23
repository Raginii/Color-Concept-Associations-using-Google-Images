function EvalReport = FittingSliceVsEllipse(ColourFrontiers, ColourSpaceCentre, FitBorderwise)
%FittingSliceVsEllipse Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
  FitBorderwise = false;
end

ColourNames = fieldnames(ColourFrontiers);

luminances = [36, 47, 58, 76, 81, 86];
EvalReport = struct();

for i = 1:numel(ColourNames)
  CurrentColour = ColourFrontiers.(ColourNames{i});
  EvalReport.(ColourNames{i}) = struct();
  for lum = luminances
    GreyPoints = [];
    LumName = ['lum', num2str(lum)];
    EvalReport.(ColourNames{i}).(LumName) = struct();
    LumPoints3 = CurrentColour.GetBorder(lum);
    if ~isempty(LumPoints3)
      LumPoints2 = LumPoints3(:, 1:2);
      % fitting to ellipse
      CurrentEllipse = FitPointsToEllipses(LumPoints2);
      [eldis, ~] = DistanceEllipse(LumPoints2, CurrentEllipse);
      EvalReport.(ColourNames{i}).(LumName).EllipseDistance = mean(eldis);
      % fitting to slice
      if FitBorderwise
        NeighbourNames = CurrentColour.GetNeighbourNames(lum);
        nNeighbours = numel(NeighbourNames);
        LineDistances = zeros(nNeighbours, 1);
        NonGrey = 0;
        for k = 1:numel(NeighbourNames)
          LumPoints3 = CurrentColour.GetBorderWithColour(lum, NeighbourNames{k});
          LumPoints2 = LumPoints3(:, 1:2);
          if ~strcmpi(NeighbourNames{k}, 'grey')
            NonGrey = NonGrey + 1;
            [LineCoeffs(NonGrey, :), lidis] = FitPointsToLine(LumPoints2); %#ok
            LineDistances(k) = mean(lidis);
          else
            GreyInd = k;
            GreyPoints = LumPoints2;
          end
        end
        if ~isempty(GreyPoints)
          EucGreyDis = zeros(size(GreyPoints, 1), NonGrey);
          for k = 1:NonGrey
            lx = [min(GreyPoints(:, 1)) - 1e10, max(GreyPoints(:, 1)) + 1e10];
            ly = polyval(LineCoeffs(k, :), lx);
            EucGreyDis(:, k) = DistanceLine([lx(1), ly(1)], [lx(end), ly(end)], GreyPoints);
          end
          LineDistances(GreyInd) = mean(min(EucGreyDis));
        end
        
        EvalReport.(ColourNames{i}).(LumName).SliceDistance = mean(LineDistances);
      else
        CurrentSlice = FitPointsToSlices(LumPoints2, ColourSpaceCentre);
        EvalReport.(ColourNames{i}).(LumName).SliceDistance = mean(CurrentSlice.error);
      end
    else
      EvalReport.(ColourNames{i}).(LumName).EllipseDistance = 0;
      EvalReport.(ColourNames{i}).(LumName).SliceDistance = 0;
    end
  end
end

hold on;
BarData = [];
ncolours = numel(ColourNames);
labels = cell(ncolours, 1);
for i = 1:ncolours
  labels{i} = ColourNames{i};
  numlums = 0;
  SliceDistance = 0;
  EllipseDistance = 0;
  for lum = luminances
    LumName = ['lum', num2str(lum)];
    SliceDistance = EvalReport.(ColourNames{i}).(LumName).SliceDistance + SliceDistance;
    EllipseDistance = EvalReport.(ColourNames{i}).(LumName).EllipseDistance + EllipseDistance;
    numlums = numlums + 1;
  end
  BarData = [BarData; SliceDistance / numlums, EllipseDistance / numlums]; %#ok
  fprintf('The mean distance for colour %s, slice %f\n', ColourNames{i}, SliceDistance / numlums);
  fprintf('The mean distance for colour %s, ellipse %f\n', ColourNames{i}, EllipseDistance / numlums);
end
fprintf('slice %f - ellipse %f\n', mean(BarData));
h = bar(BarData);
legends = {'slice', 'ellipse'};
legend(h, legends);
set(gca, 'XTickLabel', labels, 'XTick', 1:numel(labels));

end
