function [] = CleanAndSave(ExperimentParameters, SubjectName, ExperimentResults)

junkpalette = ExperimentParameters.junkpalette;
crsPaletteSet(junkpalette);
crsSetDisplayPage(4);

audioplayer(ExperimentParameters.y_DingDong, ExperimentParameters.Fs_DingDong);
audioplayer(ExperimentParameters.y_DingDong, ExperimentParameters.Fs_DingDong);
audioplayer(ExperimentParameters.y_DingDong, ExperimentParameters.Fs_DingDong);

if ~exist(char(strcat(ExperimentParameters.resultsdir, SubjectName, '\')), 'dir');
  mkdir(char(strcat(ExperimentParameters.resultsdir, SubjectName, '\')));
end

% setting the white reference of the experiment
ExperimentResults.WhiteReference = ExperimentParameters.refillum;

pathname = strcat(ExperimentParameters.resultsdir, SubjectName, '\');
filename = strcat(lower('Colour Frontiers Experiment_'), ExperimentParameters.ExperimentType, '_', datestr(now, 'yyyy-mm-dd_HH.MM.SS'));
save(char(strcat(pathname, filename, '.mat')), 'ExperimentResults');

warning off MATLAB:xlswrite:AddSheet;
[~, ~] = xlswrite(char(strcat(pathname, filename, '.xls')), [ExperimentResults.angles],     'angles');
[~, ~] = xlswrite(char(strcat(pathname, filename, '.xls')), [ExperimentResults.radii],      'radii');
[~, ~] = xlswrite(char(strcat(pathname, filename, '.xls')), [ExperimentResults.luminances], 'luminances');
[~, ~] = xlswrite(char(strcat(pathname, filename, '.xls')), [ExperimentResults.times],      'elapsed_times');
[~, ~] = xlswrite(char(strcat(pathname, filename, '.xls')), [ExperimentResults.conditions], 'presentation_order');

hold off;
pause(ExperimentParameters.endexppause)
crsPaletteSet(zeros(3, ExperimentParameters.SquareSize));
disp('Ended OK');

end
