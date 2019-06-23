function rgbs = name2rgb(ColourName)
%NAME2RGB map colour names to their RGB values for visualisation purposes.
%
% Inputs
%   ColourName  the colour name in characters
%
% Outputs
%   rgb  the RGB value of the colour name in row.
%

ColourName = cellstr(lower(ColourName));

ncolours = length(ColourName);
rgbs = zeros(ncolours, 3);
for i = 1:ncolours
  switch ColourName{i}
    case {'bl', 'black'}
      rgbs(i, :) = [0.0, 0.0, 0.0];
    case {'b', 'blue'}
      rgbs(i, :) = [0.0, 0.0, 1.0];
    case {'br', 'brown'}
      rgbs(i, :) = [1.0, 0.5, 0.0] * 0.75;
    case {'g', 'green'}
      rgbs(i, :) = [0.0, 1.0, 0.0];
    case {'gr', 'grey'}
      rgbs(i, :) = [0.5, 0.5, 0.5];
    case {'o', 'orange'}
      rgbs(i, :) = [1.0, 0.5, 0.0];
    case {'pk', 'pink'}
      rgbs(i, :) = [1.0, 0.0, 1.0];
    case {'pp', 'purple'}
      rgbs(i, :) = [0.7, 0.0, 0.7];
    case {'r', 'red'}
      rgbs(i, :) = [1.0, 0.0, 0.0];
    case {'w', 'white'}
      rgbs(i, :) = [1.0, 1.0, 1.0];
    case {'y', 'yellow'}
      rgbs(i, :) = [1.0, 1.0, 0.0];
    otherwise
      warning('name2rgb:UnsupportedColour', ['Colour ', ColourName], ' is not supported, returnign black.');
      rgbs(i, :) = [0, 0, 0];
  end
end

end
