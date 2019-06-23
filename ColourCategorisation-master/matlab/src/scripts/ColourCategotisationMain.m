%% Initialisation

clearvars;
close all;
clc;

docomparegt = true;

ColourSpace = 'lab';

GroundTruth = [];
ImageRGB = WcsChart();

%% Colour categorisation

PlotResults = true;

NaiveAdaptation = true;
BelongingImage = rgb2belonging(ImageRGB, ColourSpace, PlotResults, GroundTruth, NaiveAdaptation);

%% compare with gt
if docomparegt
  BerlinBelonging = WcsResults({'berlin'});
  SturgeBelonging = WcsResults({'sturges'});
  
  fprintf('Berlin:\n');
  PlotColourNamingDifferences(BelongingImage, BerlinBelonging);
  
  fprintf('Sturges:\n');
  PlotColourNamingDifferences(BelongingImage, SturgeBelonging);  
end
