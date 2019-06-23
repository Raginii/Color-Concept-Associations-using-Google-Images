function FigureNumber = PlotLmsOpponency(InputImage)
%PlotLmsOpponency  plots the original image with its LMS opponnecy.
%
% inputs
%   InputImage  the input image in RGB colour space.
%
% outputs
%   FigureNumber  the reference to the figure.
%

imlms = rgb2lms(InputImage);
FigureNumber = PlotRgbOpponency(imlms);

figure(FigureNumber);
subplot(2, 2, 1:2); imshow(InputImage); title('original');
subplot(2, 2, 3); title('L-M Opponency');
subplot(2, 2, 4); title('S-(L+M) Opponency');

end
