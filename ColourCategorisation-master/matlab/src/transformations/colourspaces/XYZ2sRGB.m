function outpic = XYZ2sRGB(inpic, gammacorr, refwhite)

%The option gammacorr determines whether or not the results will be linearised
%or gammacorrected for presentation on a non-linear monitor
%gammacorr = 1 : results ready to be presented on a non-linear monitor;
%The default reference white is D65 and it will be assumed that a value of [1 1 1]
%corresponds to this reference white (unless specified in refwhite).

% Viewing environment
% Luminance level	80 cd/m2
% Illuminant white point	x = 0.3127, y = 0.3291 (D65)
% Image surround reflectance	20% (~medium gray)
% Encoding ambient illuminance level	64 lux
% Encoding ambient white point	x = 0.3457, y = 0.3585 (D50)
% Encoding viewing flare	1.0%
% Typical ambient illuminance level	200 lux
% Typical ambient white point	x = 0.3457, y = 0.3585 (D50)
% Typical viewing flare	5.0%

% If a value of refwhite=0 is entered, the behaviour will be default.

[lin, col, pla] = size(inpic);
lin2 = lin;
if pla == 3
  lin2 = lin * col;
  inpic = reshape(inpic, lin2, pla);
end

if (nargin < 3) || isempty(refwhite)
  %IRblocking = IRblocking(ismember(IRblocking(:,1),400:700),2:end);
  if pla == 3
    maxlum = max(inpic(:, 2));
    refwhite = inpic(ismember(inpic(:, 2), maxlum), :);
  else
    refwhite = [1, 1, 1];
  end
end

if nargin < 2 || isempty(gammacorr)
  gammacorr = 1; %results ready to be presented on a non-linear monitor
end

%Obtained from http://en.wikipedia.org/wiki/SRGB_color_space
M = ...
  [
  3.2410, -1.5374, -0.4986;
  -0.9692,  1.8760,  0.0416;
  0.0556, -0.2040,  1.0570;
  ];

%XYZ values are such that "white" is D65 with unit luminance (X,Y,Z = 0.9505, 1.0000, 1.0890).
%This is necesary because the matrix transformation must be done between
%"normalised to 1" values
D65 = [0.9505, 1.0000, 1.0890];
inpic = (inpic ./ repmat(refwhite, lin2, 1) .* repmat(D65, lin2, 1));
P = truncate(inpic * M', [0, 1]); %matrix transformation to change spaces

if gammacorr
  outpic = 12.92 .* P .* (P <= 0.0031308) + ((1 + 0.055).* P .^ (1 / 2.4) - 0.055 ) .* (P > 0.0031308);
else
  outpic = P;
end

if pla == 3
  outpic = reshape(outpic, lin, col, pla);
end

end

function [results, where] = truncate(input, limits, warn, show)
%Example: truncate(A, [0 1]);

if nargin < 4
  show = 0;
end

if nargin < 3
  warn = 0;
end

if show
  where = ones(size(input));
else
  where = 0;
end

minim = limits(1);
maxim = limits(2);

if (max(input(:)) > maxim || min(input(:)) < minim)
  results = input .* (input >= minim) + (input < minim) .* minim;
  results = results .* (results <= maxim) + (results > maxim) .* maxim;
  if show
    where = and((input >= minim), (input <= maxim));
  end
  if warn
    disp(strcat('Warning: some values outside [', num2str(minim), ',', num2str(maxim), '] range were clipped'));
  end
else
  results = input;
end

end
