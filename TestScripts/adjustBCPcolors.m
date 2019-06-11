i = 9
RGB(i,:)
Lab(i,:)
C = makecform('lab2lch');
lch = applycform(Lab(i,:),C)
newLCH = lch;
%%
% change newLCH chromaticity
newLCH(1) = 89;
newLCH(2) = 85; %%%% make changes here 
newLAB = applycform(newLCH,makecform('lch2lab'))
newRGB = lab2rgb(newLAB)
RGB(i,:) = newRGB
Lab(i,:) = newLAB

%%
csvwrite('RGB_test.csv',RGB);
csvwrite('Lab_test.csv',Lab);