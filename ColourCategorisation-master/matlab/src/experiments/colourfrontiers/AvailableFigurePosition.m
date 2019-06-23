function AvailablePosition = AvailableFigurePosition(OtherFigures, FigureSize)
%AvailableFigurePosition finds an empty spot in the monitor
%
% Inputs
%   OtherFigures  other related figures.
%   FigureSize    the desired figure size.
%
% Outputs
%   AvailablePosition  the first available position.
%

% TODO: this is just a work around for now, it doesn't really check the
% entire monitor, fix it later on.

if nargin < 2
  FigureSize = [560, 420];
end

if nargin < 1
  OtherFigures = [];
end

if isempty(OtherFigures)
  StartPosition = [0, 0];
  AvailablePosition = [StartPosition, FigureSize];
else
  ScreenSize = get(0, 'screensize');
  LastFigure = get(OtherFigures(end), 'Position');
  
  % x direction
  if LastFigure(1) + LastFigure(3) + FigureSize(1) < ScreenSize(3)
    StartPosition(1) = LastFigure(1) + LastFigure(3);
    StartPosition(2) = LastFigure(2);
  else
    StartPosition(1) = 0;
    % y direction
    if LastFigure(2) + LastFigure(4) + FigureSize(2) < ScreenSize(4)
      StartPosition(2) = LastFigure(2) + LastFigure(4);
    else
      StartPosition(2) = 0;
    end
  end
  
  AvailablePosition = [StartPosition, FigureSize];
end

end
