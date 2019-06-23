function WcsImage = WcsChart(scale)
%WcsChart creates WCS colour chart.
%   Explanation http://www1.icsi.berkeley.edu/wcs/data.html
%
% Inputs
%   scale  should the 10x41 board be scaled, default is 1.
%
% Outputs
%   WcsImage  the WCS colour chart if scale is not given in size 10x41.
%

if nargin < 1
  scale = 1;
end

FunctionPath = mfilename('fullpath');
FilePath = strrep(FunctionPath, 'matlab/src/imagefactory/WcsChart', 'data/ColourNaming/WCS-Data-20110316/cnum-vhcm-lab-new.txt');
MunsellLab = tdfread(FilePath);

nchips = size(MunsellLab.x0x23cnum, 1);
ChipValue = zeros(nchips, 4);

ChipValue(:, 1) = MunsellLab.x0x23cnum;
ChipValue(:, 2) = MunsellLab.L0x2A;
ChipValue(:, 3) = MunsellLab.a0x2A;
ChipValue(:, 4) = MunsellLab.b0x2A;

lab = ChipValue(:, 2:4);
rgb = applycform(lab, makecform('lab2srgb'));
rgb = rgb .* 255;

WcsTable = zeros(10, 41, 3);

x = 2;
y = 1;
WcsTable(1, 1, :) = rgb(1, :);
for i = 2:nchips
  WcsTable(x, y, :) = rgb(i, :);
  y = y + 1;
  if y == 42
    y = 1;
    x = x + 1;
  end
end

for i = 2:41
  WcsTable(1, i, :) = [255, 255, 255] - 3.15 * (i - 2);
  WcsTable(10, i, :) = [0, 0, 0] + 3.15 * (i - 2);
end

WcsImage = MatRowsColsRepeat(WcsTable, scale);
WcsImage = uint8(WcsImage);

end
