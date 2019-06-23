function MacbethImage = MacbethColourChecker(scale)
%MacbethColourChecker creates Macbeth colour checker board.
%   Explanation http://en.wikipedia.org/wiki/ColorChecker
%
% Inputs
%   scale  should the 4x6 board be scaled, default is 1.
%
% Outputs
%   MacbethImage  the Macbeth colour checker if scale is not given in size
%                 4x6.
%

if nargin < 1
  scale = 1;
end

Macbeth = zeros(4, 6, 3);
Macbeth(:, :, 1) = ...
  [
  115, 196,  93,  90, 130,  99;
  220,  72, 195,  91, 160, 229;
  43,   71, 176, 238, 188,   0;
  245, 200, 160, 120,  83,  50;
  ];
Macbeth(:, :, 2) = ...
  [
  81,  149, 123, 108, 129, 191;
  123,  92,  84,  59, 189, 161;
  62,  149,  48, 200,  84, 136;
  245, 201, 161, 121,  84,  50;
  ];
Macbeth(:, :, 3) = ...
  [
  67,  129, 157,  65, 176, 171;
  45,  168,  98, 105,  62,  41;
  147,  72,  56,  22, 150, 166;
  240, 201, 161, 121,  85,  50;
  ];


MacbethImage = MatRowsColsRepeat(Macbeth, scale);
MacbethImage = uint8(MacbethImage);

end
