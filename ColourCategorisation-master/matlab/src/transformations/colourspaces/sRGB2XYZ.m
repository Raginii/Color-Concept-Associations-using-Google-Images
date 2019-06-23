function XYZ = sRGB2XYZ(CIERGB, gammacorrect, maxXYZ)

% Matrix Obtained from http://en.wikipedia.org/wiki/SRGB_color_space
% CIERGB is scaled to [0 1]
% The output of this function is in the range [0 1] unless the vector
% "maxXYZ" is provided. Then the output is in the range [0 maxXYZ]

% if gammacorrect = false, it assumes the input is already linearised.

if nargin < 3
  maxXYZ = [];
end

if nargin < 2
  gammacorrect = true;
end

% CIERGB2XYZ_E=       [0.4124 0.3576 0.1805;
%                      0.2126 0.7152 0.0722;
%                      0.0193 0.1192 0.9505];

CIERGB2XYZ_D65 = ...
  [
  0.4124564  0.3575761  0.1804375;
  0.2126729  0.7151522  0.0721750;
  0.0193339  0.1191920  0.9503041
  ];

% scale it to be between [0 1]
CIERGB = im2double(CIERGB);

[rows, cols, chns] = size(CIERGB);

if chns == 1
  if (rows ~= 1 && cols ~= 3)
    disp('Wrong XYZ matrix size... correcting');
    if (rows == 3 && cols == 1)
      CIERGB = CIERGB';
    else
      error('Can''t correct');
    end
  end
elseif chns == 3
  CIERGB = reshape(CIERGB, rows * cols, 3);
else
  error('wrong number of planes');
end

if gammacorrect
  CIERGB = CIERGB ./ 12.92 .* (CIERGB <= 0.04045) + (((CIERGB + 0.055) ./ (1 + 0.055)) .^ (2.4)) .* (CIERGB > 0.04045);
end

XYZ = CIERGB * CIERGB2XYZ_D65';

if ~isempty(maxXYZ)
  if chns == 3
    XYZ = XYZ .* repmat(maxXYZ, rows * cols, 1);
  else
    XYZ = XYZ .* repmat(maxXYZ, rows, 1);
  end
end

if chns == 3
  XYZ = reshape(XYZ, rows, cols, 3);
end

end
