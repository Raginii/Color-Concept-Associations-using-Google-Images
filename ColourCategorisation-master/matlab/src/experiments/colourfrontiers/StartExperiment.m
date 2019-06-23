function SubjectName = StartExperiment(ExperimentParameters)

disp('Experiment starting...');

CRS = ExperimentParameters.CRS;

crsPaletteSet(ExperimentParameters.blackpalette);
crsSetDrawPage(CRS.VIDEOPAGE, 2, ExperimentParameters.Black_palette_name);
crsDrawString([0, 0], 'Experiment starting...');
crsSetDrawPage(CRS.VIDEOPAGE, 3, ExperimentParameters.Black_palette_name);
crsDrawString([0, 0], 'Experiment updating...');
crsSetDrawPage(CRS.VIDEOPAGE, 4, ExperimentParameters.Black_palette_name);
crsDrawString([0, 0], 'Experiment finished...');
crsSetDisplayPage(2);

promptstr = {'Enter Subject''s name'};
inistr = {'Somebody'};
titlestr = 'Subject info';
nlines = 1;
ValidName = false;
while ~ValidName
  answer = inputdlg(promptstr, titlestr, nlines, inistr);
  if isempty(answer)
    ButtonName = questdlg('You will lose data. Are u sure?', 'Exit now?', 'Immediately!', 'No thanks', 'No thanks');
    if strcmp(ButtonName, 'Immediately!')
      % TODO: better error message
      error('Experiment cancelled');
    end
  else
    SubjectName = answer{1};
    pause(ExperimentParameters.darkadaptation);
    crsPaletteSet(ExperimentParameters.junkpalette);
    disp(['Subject name: ', SubjectName]);
    ValidName = true;
  end
end

end
