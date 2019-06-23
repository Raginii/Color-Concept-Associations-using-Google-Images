function [LineCoeffs, EucDis] = FitPointsToLine(points, plotme)
%FitPointsToLine  fits a set of points to a line and calculates distance.
%
% inputs
%   points  vector of points.
%   plotme  if passes as true the points and the line is plotted, by
%           default is false.
%
% outputs
%   LineCoeffs  the coefficients of the fitted line.
%   EucDis      euclidean distance of each point to the line.
%

if nargin < 2
  plotme = 0;
end

x = points(:, 1);
y = points(:, 2);

LineCoeffs = polyfit(x, y, 1);

if plotme
  figure;
  hold on;
  plot(x, y, 'b*');
  
  % get fitted values
  lx = linspace(min(x), max(x), 200);
  ly = polyval(LineCoeffs, lx);
  
  % plot the fitted line
  plot(lx, ly, 'r-');
end

% get fitted values
% TODO: change 1e10 to a number based on points
lx = [min(x) - 1e10, max(x) + 1e10];
ly = polyval(LineCoeffs, lx);
EucDis = DistanceLine([lx(1), ly(1)], [lx(end), ly(end)], points);

end
