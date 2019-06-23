function labs = PlotColourFrontiersResults(FilePath, condition, luminance, plotme)
%PlotColourFrontiersResults  plots the results of colour frontiers.
%
% inputs
%   FilePath   the path to the mat file.
%   condition  if interested in one specific condition.
%   luminance  if interested in one specific luminance.
%   plotme     if true itplots the lab values.
%
% outputs
%   labs  the L*a*a coordinates of the plotted poitns.
%

if nargin < 4
  plotme = false;
end

MatFile = load(FilePath);
ExperimentResult = MatFile.ExperimentResults;

angles = ExperimentResult.angles;
radii = ExperimentResult.radii;
luminances = ExperimentResult.luminances;
conditions = ExperimentResult.conditions;
ResultTable = [angles, radii, luminances, conditions'];
ExperimentColours = ExperimentResult.FrontierColours;

if ~isempty(condition)
  nexperiments = size(ResultTable, 1);
  FilteredConditions = zeros(nexperiments, 1);
  for ConditionI = condition
    FilteredConditions = ResultTable(:, 4) == ConditionI | FilteredConditions;
  end
  ResultTable = ResultTable(FilteredConditions, :);
  ExperimentColours = ExperimentColours(FilteredConditions, :);
  conditions = ResultTable(:, 4);
elseif ~isempty(luminance)
  nexperiments = size(ResultTable, 1);
  FilteredLuminances = zeros(nexperiments, 1);
  for LuminanceI = luminance
    FilteredLuminances = ResultTable(:, 3) == LuminanceI | FilteredLuminances;
  end
  ResultTable = ResultTable(FilteredLuminances, :);
  ExperimentColours = ExperimentColours(FilteredLuminances, :);
  conditions = ResultTable(:, 4);
end

nexperiments = size(ResultTable, 1);
labs = zeros(nexperiments, 3);
for i = 1:nexperiments
  labs(i, :) = pol2cart3([ResultTable(i, 1), ResultTable(i, 2), ResultTable(i, 3)], 1);
end

if plotme
  figure('NumberTitle', 'Off', 'Name', ['Colour Frontiers - ', ExperimentResult.type]);
  hold on;
  grid on;
  
  [UniqueConditions, IndexConditions, ~] = unique(conditions);
  for i = 1:size(UniqueConditions, 1)
    ColourA = ExperimentColours{IndexConditions(i), 1};
    colour1 = ExperimentColours{IndexConditions(i), 3};
    ColourB = ExperimentColours{IndexConditions(i), 2};
    colour2 = ExperimentColours{IndexConditions(i), 4};
    
    pp = [colour1(2), colour1(3)];
    plot([pp(1), 0], [pp(2), 0], 'r');
    text(pp(1), pp(2), ColourA, 'color', 'r');
    
    pp = [colour2(2), colour2(3)];
    plot([pp(1), 0], [pp(2), 0], 'r');
    text(pp(1), pp(2), ColourB, 'color', 'r');
  end
  
  plot(labs(:, 2), labs(:, 3), '*r');
end

end
