function FrontierHistogram = PlotFrontierHistogram(CartPoints, AngleStep, plotme, normalise)
%PlotFrontierHistogram  makes a histogram of one frontier and plots it.
%
% inputs
%   CartPoints  the frontier points.
%   AngleStep   the angle step between [0, 2xpi], by default 0.1.
%   plotme      if true it plots the histogram
%   normalise   if true the results are normalised to [0, 1], default true.
%
% outputs
%   FrontierHistogram  the histogram of angles.
%

if nargin < 2
  AngleStep = 0.1;
end
if nargin < 3
  plotme = false;
end
if nargin < 4
  normalise = true;
end

xbins = 0:AngleStep:2 * pi;
if isempty(CartPoints)
  FrontierHistogram = zeros(1, length(xbins));
  return;
end

PolarPoints = cart2pol3([CartPoints(:, 2), CartPoints(:, 3), CartPoints(:, 1)]);

[FrontierHistogram, centres] = hist(PolarPoints(:, 1), xbins);
if normalise
  FrontierHistogram = FrontierHistogram ./ sum(FrontierHistogram(:));
end

if plotme
  figure;
  bar(centres, FrontierHistogram);
end

end
