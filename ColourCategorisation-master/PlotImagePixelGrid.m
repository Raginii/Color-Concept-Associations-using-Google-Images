function h = PlotImagePixelGrid(InputImage, gts)
%PlotImagePixelGrid  plotting the results with gts on top
%
% inputs
%   InputImage  the labelled imaged.
%   gts         {berlin, sturge}.
%
% outputs
%   h  the figure number.
%

InputImage([1, 10], 2:end, :) = 128;
figure;
h = imshow(InputImage, 'InitialMagnification', 'fit');

hold on;

if strcmpi(gts, 'berlin')
  PlotGreenBerlin();
  PlotBlueBerlin();
  PlotPurpleBerlin();
  PlotPinkBerlin();
  PlotRedBerlin();
  PlotOrangeBerlin();
  PlotYellowBerlin();
  PlotBrownBerlin();
  PlotGreyBerlin();
  PlotWhiteBerlin();
  PlotBlackBerlin();
end

if strcmpi(gts, 'sturge')
  PlotGreenSturge();
  PlotBlueSturge();
  PlotPurpleSturge();
  PlotPinkSturge();
  PlotRedSturge();
  PlotOrangeSturge();
  PlotYellowSturge();
  PlotBrownSturge();
  PlotGreySturge();
  PlotWhiteSturge();
  PlotBlackSturge();
end

hold off;

end

function [] = PlotGreenBerlin()

x = [13.5, 20.5];
y = [3.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [20.5, 22.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [22.5, 23.5];
y = [7.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [13.5, 15.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [15.5, 23.5];
y = [9.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

x = [13.5, 13.5];
y = [3.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [15.5, 15.5];
y = [8.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [20.5, 20.5];
y = [3.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [22.5, 22.5];
y = [5.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [23.5, 23.5];
y = [7.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotBlueBerlin()

x = [23.5, 23.5];
y = [1.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [31.5, 31.5];
y = [1.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [23.5, 31.5];
y = [1.5, 1.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [23.5, 31.5];
y = [9.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotPurpleBerlin()

x = [32.5, 37.5];
y = [4.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [37.5, 38.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [38.5, 39.5];
y = [6.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [39.5, 40.5];
y = [7.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [40.5, 41.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [32.5, 41.5];
y = [9.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

x = [32.5, 32.5];
y = [4.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [37.5, 37.5];
y = [4.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [38.5, 38.5];
y = [5.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [39.5, 39.5];
y = [6.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [40.5, 40.5];
y = [7.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [41.5, 41.5];
y = [8.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotPinkBerlin()

x = [1.5, 1.5];
y = [1.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [3.5, 3.5];
y = [1.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 3.5];
y = [1.5, 1.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 3.5];
y = [4.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

x = [37.5, 41.5];
y = [1.5, 1.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [37.5, 38.5];
y = [4.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [38.5, 41.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [37.5, 37.5];
y = [1.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [38.5, 38.5];
y = [4.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [41.5, 41.5];
y = [1.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotRedBerlin()

x = [2.5, 4.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 2.5];
y = [6.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [2.5, 2.5];
y = [5.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 1.5];
y = [6.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [4.5, 4.5];
y = [5.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 4.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotOrangeBerlin()

x = [3.5, 6.5];
y = [3.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [3.5, 4.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [4.5, 6.5];
y = [6.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [3.5, 3.5];
y = [3.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [4.5, 4.5];
y = [5.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [6.5, 6.5];
y = [3.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotYellowBerlin()

x = [10.5, 12.5];
y = [1.5, 1.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [8.5, 10.5];
y = [2.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [11.5, 12.5];
y = [2.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [8.5, 11.5];
y = [3.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [10.5, 10.5];
y = [1.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [12.5, 12.5];
y = [1.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [11.5, 11.5];
y = [2.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [8.5, 8.5];
y = [2.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotBrownBerlin()

x = [6.5, 8.5];
y = [6.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [5.5, 6.5];
y = [7.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [5.5, 8.5];
y = [9.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [6.5, 6.5];
y = [6.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [5.5, 5.5];
y = [7.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [8.5, 8.5];
y = [6.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotGreyBerlin()

x = [0.5, 0.5];
y = [2.5, 8.5];
plot(x, y, 'Color', 'blue', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 1.5];
y = [2.5, 8.5];
plot(x, y, 'Color', 'blue', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [2.5, 2.5];
plot(x, y, 'Color', 'blue', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'blue', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotWhiteBerlin()

x = [0.5, 0.5];
y = [0.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 1.5];
y = [0.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [0.5, 0.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [2.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotBlackBerlin()

x = [0.5, 0.5];
y = [8.5, 10.5];
plot(x, y, 'Color', 'white', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 1.5];
y = [8.5, 10.5];
plot(x, y, 'Color', 'white', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'white', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [10.5, 10.5];
plot(x, y, 'Color', 'white', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotGreenSturge()

x = [13.5, 17.5];
y = [3.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [18.5, 20.5];
y = [3.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [17.5, 18.5];
y = [2.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [20.5, 21.5];
y = [4.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [21.5, 22.5];
y = [6.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [22.5, 23.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [13.5, 15.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [15.5, 16.5];
y = [6.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [16.5, 17.5];
y = [7.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [17.5, 19.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [19.5, 23.5];
y = [9.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

x = [13.5, 13.5];
y = [3.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [15.5, 15.5];
y = [5.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [16.5, 16.5];
y = [6.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [17.5, 17.5];
y = [7.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [19.5, 19.5];
y = [8.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [23.5, 23.5];
y = [8.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [22.5, 22.5];
y = [6.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [21.5, 21.5];
y = [4.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [20.5, 20.5];
y = [3.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [18.5, 18.5];
y = [2.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [17.5, 17.5];
y = [2.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotBlueSturge()

x = [26.5, 26.5];
y = [5.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [27.5, 27.5];
y = [3.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [28.5, 28.5];
y = [2.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [30.5, 30.5];
y = [2.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [31.5, 31.5];
y = [3.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [32.5, 32.5];
y = [5.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [28.5, 28.5];
y = [8.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [27.5, 27.5];
y = [6.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

x = [26.5, 27.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [27.5, 28.5];
y = [3.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [28.5, 30.5];
y = [2.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [30.5, 31.5];
y = [3.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [31.5, 32.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [28.5, 32.5];
y = [9.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [27.5, 28.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [26.5, 27.5];
y = [6.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotPurpleSturge()

x = [33.5, 36.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [36.5, 37.5];
y = [7.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [36.5, 37.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [33.5, 36.5];
y = [9.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

x = [33.5, 33.5];
y = [5.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [36.5, 36.5];
y = [5.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [36.5, 36.5];
y = [8.5, 9.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [37.5, 37.5];
y = [7.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotPinkSturge()

x = [1.5, 1.5];
y = [2.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [2.5, 2.5];
y = [2.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 2.5];
y = [2.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 2.5];
y = [4.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

x = [40.5, 41.5];
y = [2.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [39.5, 40.5];
y = [3.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [38.5, 39.5];
y = [4.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [38.5, 41.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

x = [38.5, 38.5];
y = [4.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [39.5, 39.5];
y = [3.5, 4.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [40.5, 40.5];
y = [2.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [41.5, 41.5];
y = [2.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotRedSturge()

x = [2.5, 4.5];
y = [6.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [2.5, 3.5];
y = [7.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [3.5, 4.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [2.5, 2.5];
y = [6.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [3.5, 3.5];
y = [7.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [4.5, 4.5];
y = [6.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotOrangeSturge()

x = [5.5, 5.5];
y = [3.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [7.5, 7.5];
y = [3.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [5.5, 7.5];
y = [3.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [5.5, 7.5];
y = [5.5, 5.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotYellowSturge()

x = [10.5, 12.5];
y = [1.5, 1.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [9.5, 10.5];
y = [2.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [11.5, 12.5];
y = [2.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [9.5, 11.5];
y = [3.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [10.5, 10.5];
y = [1.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [12.5, 12.5];
y = [1.5, 2.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [11.5, 11.5];
y = [2.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [9.5, 9.5];
y = [2.5, 3.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotBrownSturge()

x = [6.5, 9.5];
y = [6.5, 6.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [6.5, 7.5];
y = [7.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [7.5, 9.5];
y = [8.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [6.5, 6.5];
y = [6.5, 7.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [7.5, 7.5];
y = [7.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [9.5, 9.5];
y = [6.5, 8.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotGreySturge()

x = [0.5, 0.5];
y = [4.5, 6.5];
plot(x, y, 'Color', 'blue', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 1.5];
y = [4.5, 6.5];
plot(x, y, 'Color', 'blue', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [4.5, 4.5];
plot(x, y, 'Color', 'blue', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [6.5, 6.5];
plot(x, y, 'Color', 'blue', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotWhiteSturge()

x = [0.5, 0.5];
y = [0.5, 1.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 1.5];
y = [0.5, 1.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [0.5, 0.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [1.5, 1.5];
plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 3);

end

function [] = PlotBlackSturge()

x = [0.5, 0.5];
y = [9.5, 10.5];
plot(x, y, 'Color', 'white', 'LineStyle', '-', 'LineWidth', 3);
x = [1.5, 1.5];
y = [9.5, 10.5];
plot(x, y, 'Color', 'white', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [9.5, 9.5];
plot(x, y, 'Color', 'white', 'LineStyle', '-', 'LineWidth', 3);
x = [0.5, 1.5];
y = [10.5, 10.5];
plot(x, y, 'Color', 'white', 'LineStyle', '-', 'LineWidth', 3);

end
