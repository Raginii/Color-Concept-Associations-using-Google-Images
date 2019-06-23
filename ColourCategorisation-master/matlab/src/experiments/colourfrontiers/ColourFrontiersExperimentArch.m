function [] = ColourFrontiersExperimentArch()

%% initialisation

% cleaning the workspace
clearvars;
close all;
clc;

% getting the start time
StartTime = tic;

% creating the colour frontiers
FrontierTable = ColourFrontiers();

% invoque the list of nameable colours from the literature
[~, PolarFocals] = FocalColours();

%% CRS setup

% setting the monitor up
crsStartup;
crsSet24bitColourMode;
crsSetColourSpace(CRS.CS_RGB);
% Gammacorrect should be turned off when showing non-linear images
crsSetVideoMode(CRS.EIGHTBITPALETTEMODE + CRS.NOGAMMACORRECT);

%% experiment parameters

ExperimentParameters = CreateExperimentParameters(CRS, 'Arch');

% (the margin the observer is allowed to wander outside the focus colour bracket (in radians)
ang_margin_fraction = 0.1;

%% preparing the experiment

% TODO: should I add this 'binomials'?
[FrontierTable, conditions] = GetExperimentConditions(FrontierTable, ExperimentParameters);

disp('Finding possible radioes. Please wait....');
% find the largest radious possible within the limits of the monitor
FrontierTable = NeighbourArchs(ExperimentParameters, PolarFocals, FrontierTable);

if ExperimentParameters.plotresults
  FigurePlanes = unique(FrontierTable(:, 1));
  FigurePlanes{1, 2} = [];
  for i = 1:size(FigurePlanes, 1)
    AvailablePosition = AvailableFigurePosition(cell2mat(FigurePlanes(:, 2)));
    FigurePlanes{i, 2} = figure;
    set(FigurePlanes{i, 2}, 'Name', ['Plane L= ', FigurePlanes{i, 1}], 'NumberTitle', 'off', 'position', AvailablePosition);
    hold on;
    % plotting all the borders at the start
    PlaneIndex = ~cellfun('isempty', strfind(FrontierTable(:, 1), FigurePlanes{i, 1}));
    PlaneTable = FrontierTable(PlaneIndex, :);
    for j = 1:size(PlaneTable, 1)
      PlotColour(PlaneTable(j, :), PolarFocals);
    end
  end
end

totnumruns = length(conditions);

% the parameters that we save in excel
ExperimentResults.angles = zeros(totnumruns, 1);
ExperimentResults.radii = zeros(totnumruns, 1);
ExperimentResults.luminances = zeros(totnumruns, 1);
ExperimentResults.times = zeros(totnumruns, 1);
ExperimentResults.conditions = conditions;
ExperimentResults.type = ExperimentParameters.ExperimentType;
ExperimentResults.background = ExperimentParameters.BackgroundType;
ExperimentResults.background = ExperimentParameters.BackgroundType;
ExperimentResults.FrontierColours = cell(totnumruns, 4);

ExperimentResults.startangles = zeros(totnumruns, 1);
ExperimentResults.anglelimits = zeros(totnumruns, 2);

%% start of experiment

SubjectName = StartExperiment(ExperimentParameters);

crsResetTimer();

condition_elapsedtime = 0;
ExperimentCounter = 1;
QuitApplication = 0;
for borderNr = conditions
  if QuitApplication
    break;
  end
  % selecting the figure for this condition
  if ExperimentParameters.plotresults
    FigureIndex = ~cellfun('isempty', strfind(FigurePlanes(:, 1), FrontierTable{borderNr, 1}));
    h = FigurePlanes{FigureIndex, 2};
    figure(h);
  end
  
  % selection the borders of this condition
  [radius1, radius2, start_ang, end_ang, theplane, startcolourname, endcolourname] = ArchColour(FrontierTable(borderNr, :), PolarFocals);
  
  if start_ang > end_ang
    end_ang = end_ang + 2 * pi();
  end
  
  LabColour1 = pol2cart3([start_ang, radius1, theplane], 1);
  LabColour2 = pol2cart3([end_ang,   radius2, theplane], 1);
  
  % choose distance to centre
  ang_margin = ang_margin_fraction * abs(end_ang - start_ang);
  
  isLine = strcmpi('line', FrontierTable{borderNr, 4});
  if isLine
    ini_angularstep = 1;
    nLinePoints = 100;
    PointsBetweenColours = [linspace(LabColour1(2), LabColour2(2), nLinePoints); linspace(LabColour1(3), LabColour2(3), nLinePoints)];
    PointIndex = 50;
    PolarColour = cart2pol3([PointsBetweenColours(1, PointIndex), PointsBetweenColours(2, PointIndex), theplane]);
    current_angle = PolarColour(1);
    current_radius = PolarColour(2);
  else
    ini_angularstep = 0.01;
    % randomise between 0.5 to 1.0 so we wont be close to grey
    current_angle = start_ang + (end_ang - start_ang) * (0.5 * rand + 0.5);
    current_radius = (radius1 + radius2) / 2;
  end
  
  ExperimentResults.startangles(ExperimentCounter) = current_angle;
  
  % generating mondrian
  [~, ~, ~, palette] = GenerateMondrian(ExperimentParameters, current_angle, current_radius, theplane, startcolourname, endcolourname);
  
  wavplay(ExperimentParameters.y_DingDong, ExperimentParameters.Fs_DingDong); %#ok
  condition_starttime = crsGetTimer();
  
  ExperimentResults.FrontierColours(ExperimentCounter, :) = {startcolourname, endcolourname, LabColour1, LabColour2};
  % displaying experiment information
  disp('===================================');
  disp(['Current colour border: ', startcolourname,' - ', endcolourname]);
  disp(['Radious #', num2str(ExperimentCounter), ' : ', num2str(current_radius)]);
  disp([startcolourname, ' Lab colour: ', num2str(LabColour1)]);
  disp([endcolourname,   ' Lab colour: ', num2str(LabColour2)]);
  disp(['Luminance Plane: ', num2str(theplane)]);
  disp(['Start up angle: ', num2str(current_angle), ' rad']);
  disp(['There are still ', num2str(totnumruns - ExperimentCounter - 1), ' runs to go (', num2str(round((ExperimentCounter - 1) / totnumruns * 100)), '% completed).']);
  
  % joystick loop quit condition variable
  QuitButtonPressed = 0;
  % activate joystick
  joystick on;
  
  all_buttons = [1, 2, 5, 6, 7, 8, 9];
  angularstep = ini_angularstep;
  
  while QuitButtonPressed == 0
    % get the joystick response.
    new_buttons = joystick('get' , all_buttons);
    if isLine
      Shift = PointIndex;
    else
      Shift = 0;
    end
    if new_buttons(1) && new_buttons(2)
      QuitButtonPressed = 1;
      QuitApplication = 1;
      break;
    end
    if new_buttons(3)
      % left correction
      Shift = Shift - angularstep;
    end
    if new_buttons(4)
      % right correction
      Shift = Shift + angularstep;
    end
    if new_buttons(5)
      % left correction
      Shift = Shift - ExperimentParameters.fastsampling * angularstep;
    end
    if new_buttons(6)
      % right correction
      Shift = Shift + ExperimentParameters.fastsampling * angularstep;
    end
    if new_buttons(7)
      % indicates last run.
      QuitButtonPressed = 1;
      condition_elapsedtime = crsGetTimer() - condition_starttime;
      wavplay(ExperimentParameters.y_ding , ExperimentParameters.Fs_ding); %#ok
      UpdatePlotCurrentBorder(current_angle, current_radius, ExperimentParameters.plotresults, 'or');
      Shift = -1;
    end
    if Shift ~= -1
      % this pause is necessary due to behaviour of the joystick in order
      % to slow the adquisition process.
      pause(ExperimentParameters.joystickdelay);
      
      UpdatePlotCurrentBorder(current_angle, current_radius, ExperimentParameters.plotresults, '.b');
      
      if isLine
        if Shift < 1
          PointIndex = 1;
          angularstep = -angularstep;
        elseif Shift > nLinePoints
          PointIndex = nLinePoints;
          angularstep = -angularstep;
        else
          PointIndex = Shift;
        end
        PolarColour = cart2pol3([PointsBetweenColours(1, PointIndex), PointsBetweenColours(2, PointIndex), theplane]);
        current_angle = PolarColour(1);
        current_radius = PolarColour(2);
      else
        % update current angle
        current_angle = current_angle + Shift;
        if current_angle > end_ang + ang_margin
          current_angle = end_ang + ang_margin;
          angularstep = -angularstep;
        end
        if current_angle < start_ang - ang_margin
          current_angle = start_ang - ang_margin;
          angularstep = -angularstep;
        end
      end
      
      % update the CRT
      palette(ExperimentParameters.Central_patch_name, :) = Lab2CRSRGB(ExperimentParameters.CRS, pol2cart3([current_angle, current_radius, theplane], 1), ExperimentParameters.refillum, 0);
      crsPaletteSet(palette');
      UpdatePlotCurrentBorder(current_angle, current_radius, ExperimentParameters.plotresults, '.r');
    end
  end
  
  % deactivate joystick
  joystick off;
  
  crsPaletteSet(ExperimentParameters.junkpalette);
  crsSetDisplayPage(3);
  
  % displaying the final selected border
  disp(['Selected angle: ', num2str(current_angle), ' rad']);
  disp(['Final Lab colour: ', num2str(pol2cart3([current_angle, current_radius, theplane], 1))]);
  disp(['Time elapsed: ', num2str(condition_elapsedtime / 1000000), ' secs']);
  
  % collect results and other junk
  ExperimentResults.angles(ExperimentCounter) = current_angle;
  ExperimentResults.radii(ExperimentCounter) = current_radius;
  ExperimentResults.luminances(ExperimentCounter) = theplane;
  ExperimentResults.times(ExperimentCounter) = condition_elapsedtime / 1000000;
  
  ExperimentResults.anglelimits(ExperimentCounter, :) = [start_ang - ang_margin, end_ang + ang_margin];
  
  ExperimentCounter = ExperimentCounter + 1;
end

%% cleaning and saving

toc(StartTime)

CleanAndSave(ExperimentParameters, SubjectName, ExperimentResults);

end

%% ArchColour

function [radius1, radius2, start_ang, end_ang, labplane, ColourA, ColourB] = ArchColour(frontier, PolarFocals)

ColourA = lower(frontier{2});
ColourB = lower(frontier{3});
labplane = str2double(frontier{1});

PoloarColourA = PolarFocals.(ColourA)((PolarFocals.(ColourA)(:, 3) == labplane), :);
PoloarColourB = PolarFocals.(ColourB)((PolarFocals.(ColourB)(:, 3) == labplane), :);

disp(['luminance: ', frontier{1}, ', ', ColourA, '-', ColourB, ' border selected']);
IndexMaxRadius = size(frontier, 2);
if strcmpi('line', frontier{4})
  radius_pn1 = frontier{IndexMaxRadius - 1};
  minradius1 = 0.95 * radius_pn1;
  radius1 = minradius1 + (radius_pn1 - minradius1) * rand(1, 1);
  
  radius_pn2 = frontier{IndexMaxRadius};
  minradius2 = 0.95 * radius_pn2;
  radius2 = minradius2 + (radius_pn2 - minradius2) * rand(1, 1);
else
  radius_pn = frontier{IndexMaxRadius};
  minradius = 0.95 * radius_pn;
  radius1 = minradius + (radius_pn - minradius) * rand(1, 1);
  radius2 = radius1;
end
start_ang = PoloarColourA(1);
end_ang = PoloarColourB(1);

end

%% PlotColour

function [] = PlotColour(frontier, PolarFocals)

ColourA = lower(frontier{2});
ColourB = lower(frontier{3});
labplane = str2double(frontier{1});

PoloarColourA = PolarFocals.(ColourA)((PolarFocals.(ColourA)(:, 3) == labplane), :);
PoloarColourB = PolarFocals.(ColourB)((PolarFocals.(ColourB)(:, 3) == labplane), :);

IndexMaxRadius = size(frontier, 2);

pp = pol2cart3([PoloarColourA(1), frontier{IndexMaxRadius - 1}]);
plot([pp(1), 0], [pp(2), 0], 'r');
text(pp(1), pp(2), ColourA, 'color', 'r');

pp = pol2cart3([PoloarColourB(1), frontier{IndexMaxRadius}]);
plot([pp(1), 0], [pp(2), 0], 'r');
text(pp(1), pp(2), ColourB, 'color', 'r');

refresh;

end

%% NeighbourArchs

function FrontierTableArchs = NeighbourArchs(ExperimentParameters, PolarFocals, FrontierTable)

crs = ExperimentParameters.CRS;

[rows, cols] = size(FrontierTable);
FrontierTableArchs = cell(rows, cols + 2);

for i = 1:rows
  labplane = str2double(lower(FrontierTable{i, 1}));
  ColourA = lower(FrontierTable{i, 2});
  ColourB = lower(FrontierTable{i, 3});
  PoloarColourA = PolarFocals.(ColourA)((PolarFocals.(ColourA)(:, 3) == labplane), :);
  PoloarColourB = PolarFocals.(ColourB)((PolarFocals.(ColourB)(:, 3) == labplane), :);
  if strcmpi('line', FrontierTable{i, 4})
    MaxRadiusAllowed1 = find_max_rad_allowed(crs, PoloarColourA(1), PoloarColourA(1), labplane);
    MaxRadiusAllowed2 = find_max_rad_allowed(crs, PoloarColourB(1), PoloarColourB(1), labplane);
  else
    MaxRadiusAllowed1 = find_max_rad_allowed(crs, PoloarColourA(1), PoloarColourB(1), labplane);
    MaxRadiusAllowed2 = MaxRadiusAllowed1;
  end
  % adding the last column and the allowed radius
  FrontierTableArchs(i, :) = {FrontierTable{i, :}, MaxRadiusAllowed1, MaxRadiusAllowed2};
end

end
