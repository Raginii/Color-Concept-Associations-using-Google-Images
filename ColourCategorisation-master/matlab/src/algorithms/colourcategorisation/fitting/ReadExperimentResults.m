function [ColourFrontiers, borders] = ReadExperimentResults(FilePath, ColourFrontiers, borders, XYZ2lsYChoise, BackgroundType)
%ReadExperimentResults  maps the colour frontiers result to its object.
%
% inputs
%   FilePath         the path to the mat file.
%   ColourFrontiers  previous list of colour frontiers, by default is empty,
%                    if it's not empty the new frontiers are added to this
%                    list.
%   borders          previous list of colour borders, by default is empty,
%                    if it's not empty the new borders are added to this
%                    list.
%   XYZ2lsYChoise    the choise of lsY space, if false lab is used.
%   BackgroundType   0 = both, 1 = chromatic, 2 = achromatic
%
% outputs
%   ColourFrontiers  the updated list of colour frontiers.
%   borders          the updated list of borders.
%

if nargin < 3
  ColourFrontiers = struct();
  borders = {};
  
  % colour objects
  ColourFrontiers.black  = ColourCategory('black');
  ColourFrontiers.blue   = ColourCategory('blue');
  ColourFrontiers.brown  = ColourCategory('brown');
  ColourFrontiers.green  = ColourCategory('green');
  ColourFrontiers.grey   = ColourCategory('grey');
  ColourFrontiers.orange = ColourCategory('orange');
  ColourFrontiers.pink   = ColourCategory('pink');
  ColourFrontiers.purple = ColourCategory('purple');
  ColourFrontiers.red    = ColourCategory('red');
  ColourFrontiers.yellow = ColourCategory('yellow');
  ColourFrontiers.white  = ColourCategory('white');
end
if nargin < 4
  XYZ2lsYChoise = 'evenly_ditributed_stds';
end
if nargin < 5
  BackgroundType = 0;
end

MatFile = load(FilePath);
ExperimentResult = MatFile.ExperimentResults;

if strcmpi(ExperimentResult.type, 'arch') || strcmpi(ExperimentResult.type, 'centre')
  [ColourFrontiers, borders] = DoArchCentre(ColourFrontiers, borders, ExperimentResult, XYZ2lsYChoise, BackgroundType);
elseif strcmpi(ExperimentResult.type, 'lum')
  % FIXME: how to integrate luminance
  [ColourFrontiers, borders] = DoLuminance(ColourFrontiers, borders, ExperimentResult, XYZ2lsYChoise, BackgroundType);
end

end

% TODO: make this code more readable
function [ColourFrontiers, borders] = DoArchCentre(ColourFrontiers, borders, ExperimentResult, XYZ2lsYChoise, BackgroundType)

% we are looking only for colour backsground
if BackgroundType == 1
  % colour background is -2 in experiment data.
  if ExperimentResult.background ~= -2
    return;
  end
end
% we are looking only for achromatic backsground
if BackgroundType == 2
  % achromatic background is 0 and -1 in experiment data.
  if ExperimentResult.background == -2
    return;
  end
end

angles = ExperimentResult.angles;
radii = ExperimentResult.radii;
luminances = ExperimentResult.luminances;
FrontierColours = ExperimentResult.FrontierColours;
WhiteReference = ExperimentResult.WhiteReference;

nborders = length(unique(ExperimentResult.conditions));
nexperiments = length(angles);
nluminances = unique(luminances);
nconditions = floor(nexperiments / nborders);

% containts the points for different luminances
lsys = struct();
% counter for each luminance
lcounter = struct();
lsysnames = struct();

for i = 1:length(nluminances)
  LumName = ['lum', num2str(nluminances(i))];
  lsys.(LumName) = zeros(nconditions, 3);
  lcounter.(LumName) = 1;
  lsysnames.(LumName) = cell(nconditions, 2);
end

for i = 1:nexperiments
  lab = pol2cart3([angles(i), radii(i), luminances(i)], 1);
  LumName = ['lum', num2str(luminances(i))];
  if ~XYZ2lsYChoise
    lsys.(LumName)(lcounter.(LumName), :) = lab;
  else
    lsys.(LumName)(lcounter.(LumName), :) = XYZ2lsY(Lab2XYZ(lab, WhiteReference), XYZ2lsYChoise);
  end
  ColourA = lower(FrontierColours{i, 1});
  ColourB = lower(FrontierColours{i, 2});
  lsysnames.(LumName)(lcounter.(LumName), :) = {ColourA, ColourB};
  lcounter.(LumName) = lcounter.(LumName) + 1;
end

for i = 1:length(nluminances)
  LumName = ['lum', num2str(nluminances(i))];
  
  for k = 1:nconditions
    ColourA = lsysnames.(LumName){k, 1};
    ColourB = lsysnames.(LumName){k, 2};
    
    border = [];
    for j = 1:length(borders)
      colour1 = borders{j}.colour1.name;
      colour2 = borders{j}.colour2.name;
      if (strcmpi(colour1, ColourA) || strcmpi(colour1, ColourB)) && ...
          (strcmpi(colour2, ColourA) || strcmpi(colour2, ColourB))
        border = borders{j};
        border = border.AddPoints(lsys.(LumName)(k, :), nluminances(i));
        ColourFrontiers.(ColourA) = ColourFrontiers.(ColourA).SetBorder(border);
        ColourFrontiers.(ColourB) = ColourFrontiers.(ColourB).SetBorder(border);
        borders{j} = border;
        break;
      end
    end
    
    if isempty(border)
      border = ColourBorder(ColourFrontiers.(ColourA), ColourFrontiers.(ColourB), lsys.(LumName)(k, :), nluminances(i));
      ColourFrontiers.(ColourA) = ColourFrontiers.(ColourA).AddBorder(border);
      ColourFrontiers.(ColourB) = ColourFrontiers.(ColourB).AddBorder(border);
      borders{end + 1} = border; %#ok<AGROW>
    end
  end
end

end

function [ColourFrontiers, borders] = DoLuminance(ColourFrontiers, borders, ExperimentResult, XYZ2lsYChoise, BackgroundType)

% we are looking only for colour backsground
if BackgroundType == 1
  % colour background is -2 in experiment data.
  if ExperimentResult.background ~= -2
    return;
  end
end
% we are looking only for achromatic backsground
if BackgroundType == 2
  % achromatic background is 0 and -1 in experiment data.
  if ExperimentResult.background == -2
    return;
  end
end

angles = ExperimentResult.angles;
radii = ExperimentResult.radii;
luminances = ExperimentResult.luminances;
FrontierColours = ExperimentResult.FrontierColours;
WhiteReference = ExperimentResult.WhiteReference;

nexperiments = length(angles);

LumName = 0;

lsys = zeros(nexperiments, 3);
lsysnames = cell(nexperiments, 2);

for i = 1:nexperiments
  lab = pol2cart3([angles(i), radii(i), luminances(i)], 1);
  if ~XYZ2lsYChoise
    lsys(i, :) = lab;
  else
    lsys(i, :) = XYZ2lsY(Lab2XYZ(lab, WhiteReference), XYZ2lsYChoise);
  end
  ColourA = lower(FrontierColours{i, 1});
  ColourB = lower(FrontierColours{i, 2});
  lsysnames(i, :) = {ColourA, ColourB};
  
  border = [];
  for j = 1:length(borders)
    colour1 = borders{j}.colour1.name;
    colour2 = borders{j}.colour2.name;
    if (strcmpi(colour1, ColourA) || strcmpi(colour1, ColourB)) && ...
        (strcmpi(colour2, ColourA) || strcmpi(colour2, ColourB))
      border = borders{j};
      border = border.AddPoints(lsys(i, :), LumName);
      ColourFrontiers.(ColourA) = ColourFrontiers.(ColourA).SetBorder(border);
      ColourFrontiers.(ColourB) = ColourFrontiers.(ColourB).SetBorder(border);
      borders{j} = border;
      break;
    end
  end
  
  if isempty(border)
    border = ColourBorder(ColourFrontiers.(ColourA), ColourFrontiers.(ColourB), lsys(i, :), LumName);
    ColourFrontiers.(ColourA) = ColourFrontiers.(ColourA).AddBorder(border);
    ColourFrontiers.(ColourB) = ColourFrontiers.(ColourB).AddBorder(border);
    borders{end + 1} = border; %#ok<AGROW>
  end
end

end
