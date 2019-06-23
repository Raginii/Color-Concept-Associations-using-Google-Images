function [] = PlotAllEllipsoids(varargin)
%PlotAllEllipsoids plotting all the ellipsoids from different inputs.

FigureNumber = 0;

if ischar(varargin{1})
  MatFile = load(varargin{1});
  ellipsoids = MatFile.ColourEllipsoids;
  rgbs = name2rgb(MatFile.RGBTitles);
  if nargin == 2
    FigureNumber = varargin{2};
  end
else
  ellipsoids = varargin{1};
  rgbs = varargin{2};
  if nargin == 3
    FigureNumber = varargin{3};
  end
end

if FigureNumber == 0
  figure('NumberTitle', 'Off', 'Name', 'Colour Categorisation - Ellipsoids');
end
for i = 1:size(ellipsoids, 1)
  DrawEllipsoid(ellipsoids(i, :), 'FaceColor', [0, 0, 0], 'EdgeColor', rgbs(i, :), 'FaceAlpha', 0.9);
  hold on;
end

end
