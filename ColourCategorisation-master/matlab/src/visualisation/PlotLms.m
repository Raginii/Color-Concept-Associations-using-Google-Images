function FigureNumber = PlotLms(InputImage)
%PlotLms  plots the original image along with its L, M and S channels,
%
% inputs
%   InputImage  the input image in RGB colour space.
%
% outputs
%   FigureNumber  the reference to the figure.
%

imlms = rgb2lms(InputImage);
FigureNumber = PlotRgb(imlms);

figure(FigureNumber);
subplot(2, 2, 1); imshow(InputImage); title('original');
subplot(2, 2, 2); title('L Channel');
subplot(2, 2, 3); title('M Channel');
subplot(2, 2, 4); title('S Channel');

end
