function ExperimentParameters = CreateExperimentParameters(CRS, ExperimentType)
%CreateExperimentParameters Summary of this function goes here
%   Detailed explanation goes here

ExperimentParameters = struct();

% 'all'        --> does all conditions (may take too long!!)
% '36'         --> does only the low luminance boders
% '58'         --> does only the mid-luminance borders
% '81'         --> does only the hight luminance borders
% 'binomials'  --> does only the borders that gave binomial distributions
%                  using the previous paradigm
ExperimentParameters.which_level = {'25', '47', '70'};

% x >= 0  --> no mondrians, presents colours on a grey background with
%             luminance 'x'.
% x = -1  --> does only luminance mondrians
% x = -2  --> does colour mondrians
% a white "frame" is present in all conditions
ExperimentParameters.BackgroundType = 0;

% time in seconds for the dark adaptation period (should be 120)
ExperimentParameters.darkadaptation = 120;

% the total number of conditions, it should be 50 by default
ExperimentParameters.numcolconditions = 10;

ExperimentParameters.endexppause = 15;

ExperimentParameters.ExperimentType = ExperimentType;

% TODO: make the paths dynamic
ExperimentParameters.resultsdir = 'D:\Results\ColourFrontiersExperiment\';
[y_ding, Fs_ding, ~] = wavread('D:\MatLab_m-files\Visage\Jordi\sound\sound_ding.wav'); %#ok
[y_DingDong, Fs_DingDong, ~] = wavread('D:\MatLab_m-files\Visage\Jordi\sound\DingDong.wav'); %#ok
ExperimentParameters.y_ding = y_ding;
ExperimentParameters.Fs_ding = Fs_ding;
ExperimentParameters.y_DingDong = y_DingDong;
ExperimentParameters.Fs_DingDong = Fs_DingDong;


ExperimentParameters.fastsampling = 5;
ExperimentParameters.Black_palette_name = 2;
ExperimentParameters.Central_patch_name = 3;

ExperimentParameters.joystickdelay = 0.05;

WhiteCIE1931 = crsSpaceToSpace(CRS.CS_RGB, [1, 1, 1], CRS.CS_CIE1931, 0);
ExperimentParameters.refillum = whitepoint('d65') ./ max(whitepoint('d65')) .* WhiteCIE1931(3);

ExperimentParameters.plotresults = 1;

% this was actually measured!
MinimD65 = [0.001; 0.003; 0.005];
ExperimentParameters.SquareSize = 256;
SquareSize = ExperimentParameters.SquareSize;
ExperimentParameters.blackpalette = repmat(MinimD65, 1, SquareSize);
ExperimentParameters.junkpalette = ExperimentParameters.blackpalette;
ExperimentParameters.junkpalette(:, SquareSize) = [SquareSize; SquareSize; SquareSize];

ExperimentParameters.CRS = CRS;

end
