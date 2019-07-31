% % % Creates RGB and LAB values for the defined colors
filename = "BCP37coordinates.xlsx";
colors_xyY = xlsread(filename);

% BCP illuminant = [0.312, 0.318, 116]
colors = colorconvert( colors_xyY, 'xyY', [0.312, 0.318, 116], 'xyY' )
Lab = [colors.L colors.a colors.b];
%scatter3(Lab(:,2),Lab(:,3),Lab(:,1),50,cat,'filled','MarkerEdgeColor',[0 0 0]);
%%
RGB = lab2rgb(Lab)

%%
% colors modified: 9(SY), 17(SG), 21(SC), 37(WH)
% SY: lightness from 91.08 to 89, chroma from 86.87 to 85  delE = 2.80
% SG:  chroma change was from 64.77 to 59.7 delE = 5.07
% SC:   chroma from 44.73 to 43.2  delE = 1.53
% WH:   chroma from  1.1409 to 0   delE = 1.1409
% (to bring them back to RGB  gamut)

i = 9
RGB(i,:)
Lab(i,:)
C = makecform('lab2lch');
lch = applycform(Lab(i,:),C)
newLCH = lch;
%%
% change newLCH chromaticity
newLCH(1) = 89;
%newLCH(2) = 85; %%%% make changes here 
newLAB = applycform(newLCH,makecform('lch2lab'))
newRGB = lab2rgb(newLAB)
% RGB(i,:) = newRGB
% Lab(i,:) = newLAB

%%
csvwrite('RGB_test.csv',RGB);
csvwrite('Lab_test.csv',Lab);