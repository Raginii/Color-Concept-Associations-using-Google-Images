function FigureNumber = PlotRgbOpponency(InputImage)
%PlotRgbOpponency  plots the original image with its opponnent channels.
%
% inputs
%   InputImage  the input image in RGB colour space.
%
% outputs
%   FigureNumber  the reference to the figure.
%

rgim(:, :, 1) =  InputImage(:, :, 1) - InputImage(:, :, 2);
rgim(:, :, 2) = -InputImage(:, :, 1) + InputImage(:, :, 2);
rgim(:, :, 3) = 0;
rgim = NormaliseChannel(rgim, [], [], [], []);

ybim(:, :, 1) =  InputImage(:, :, 1) + InputImage(:, :, 2) - InputImage(:, :, 3);
ybim(:, :, 2) =  InputImage(:, :, 1) + InputImage(:, :, 2) - InputImage(:, :, 3);
ybim(:, :, 3) = -InputImage(:, :, 1) - InputImage(:, :, 2) + InputImage(:, :, 3);
ybim = NormaliseChannel(ybim, [], [], [], []);

FigureNumber = figure;
subplot(2, 2, 1:2); imshow(InputImage); title('original');
subplot(2, 2, 3); imshow(rgim); title('R-G Opponency');
subplot(2, 2, 4); imshow(ybim); title('Y-B Opponency');

end
