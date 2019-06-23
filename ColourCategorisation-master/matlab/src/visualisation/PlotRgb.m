function FigureNumber = PlotRgb(InputImage)
%PlotRgb  plots the original image along with its R, G, B channels,
%
% inputs
%   InputImage  the input image in RGB colour space.
%
% outputs
%   FigureNumber  the reference to the figure.
%

rch = InputImage(:, :, 1);
gch = InputImage(:, :, 2);
bch = InputImage(:, :, 3);

lim = rch;
lim(:, :, 2:3) = 0;
lim = uint8(lim);

sim = bch;
sim(:, :, 3) = sim(:, :, 1);
sim(:, :, 1:2) = 0;
sim = uint8(sim);

mim = gch;
mim(:, :, 2) = mim;
mim(:, :, [1, 3]) = 0;
mim = uint8(mim);

FigureNumber = figure;
subplot(2, 2, 1); imshow(InputImage); title('original');
subplot(2, 2, 2); imshow(lim); title('R Channel');
subplot(2, 2, 3); imshow(sim); title('G Channel');
subplot(2, 2, 4); imshow(mim); title('B Channel');

end
