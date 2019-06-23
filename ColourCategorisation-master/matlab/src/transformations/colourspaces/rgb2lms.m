function imlms = rgb2lms(imrgb)
% img_LMS = RGBtoLMS(img_in);
% img_in is the ugly LINEAR version !!

img_RGB = double(imrgb); % make sure of type double

% this is an intermediate step, converting into some standard color space
img_XYZ = sRGB2XYZ(img_RGB, false, []);

% for the next step, there are lots of possible ways
%    norm    = 'crossingandwhitepoint';
% 'A compromise between mapping the white locus while trying to be consistent with crossings.';

norm = 'unity';
% 'normalisation is such that the max value is 1 for all fundamentals';
imlms = xyz2lms(img_XYZ, norm);
% plane 1  is Long wavelength cone
% plane 2  is Medium wavelength cone
% plane 3  is Short wavelength cone

end
