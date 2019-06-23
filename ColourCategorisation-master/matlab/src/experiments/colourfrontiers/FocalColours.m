function [CartFocals, PolarFocals] = FocalColours()
%FocalColours Summary of this function goes here
%   Detailed explanation goes here

% TODO: add other luminances here

CartFocals = struct();

%% black

CartFocals.black = ...
  [
  0,  0,  0;
  ];

%% blue

blue58 = ...
  [
  58  -3.410  -48.08;  % B&K
  58  -9.610  -18.44;  % B&O
  58  -16.44  -30.00;  % B&V
  58  -12.92  -27.22;  % S&W
  ];

CartFocals.blue = ...
  [
  36,  -5,   -30;  % B&V
  47,  -8,   -30;
  mean(blue58);
  70,  -15,  -25;
  81,  -20,  -20;  % B&V
  ];

%% brown

CartFocals.brown = ...
  [
  36,  10,  39;
  47,  10,  54;
  58,  10,  59;
  ];

%% green

green58 = ...
  [
  58  -52.69  9.700;  % B&K
  58  -22.60  24.65;  % B&O
  58  -21.41  14.72;  % B&V
  58  -38.09  22.89;  % S&W
  ];

CartFocals.green = ...
  [
  36,  -38,  22;  % B&V
  47,  -38,  22;  % S&W
  mean(green58);
  70,  -22,  24;  % B&O
  76,  -20,  20;
  81,  -20,  20;  % B&V
  86,  -20,  20;
  ];

%% grey

CartFocals.grey = ...
  [
  36,  0,  0;
  47,  0,  0;
  58,  0,  0;
  70,  0,  0;
  76,  0,  0;
  81,  0,  0;
  86,  0,  0;
  ];

%% orange

CartFocals.orange = ...
  [
  58,  35,  58;
  70,  35,  65;
  76,  20,  30;
  81,  15,  25;
  86,  10,  25;
  ];

%% pink

pink81 = ...
  [
  81  37   7;  % B&V
  81  50  10;  % B&V
  ];

CartFocals.pink = ...
  [
  58,  73,  -12;
  70,  45,  -6;
  76,  45,  -6;
  mean(pink81);
  ];

%% purple

purple58 = ...
  [
  58  20  -30;  % B&V
  58  30  -40;  % B&V
  ];

purple81 = ...
  [
  81  20  -25;  % B&V
  81  25  -27;  % B&V
  ];

CartFocals.purple = ...
  [
  36,  64,  -61;
  47,  69,  -66;
  mean(purple58);
  70,  23,  -31;
  76,  23,  -31;
  mean(purple81);
  ];

%% red

CartFocals.red = ...
  [
  36,  54,  10;
  47,  64,  20;
  58,  64,  20;
  ];

%% white

CartFocals.white = ...
  [
  100,  0,  0;
  ];

%% yellow

CartFocals.yellow = ...
  [
  76,  -10,  76;
  81,  -10,  75;
  86,  -10,  75;
  ];

%% converting them to polar

PolarFocals = struct();
ColourNames = fieldnames(CartFocals);
for i = 1:numel(ColourNames)
  PolarFocals.(ColourNames{i}) = cart2pol3([CartFocals.(ColourNames{i})(:, 2:3), CartFocals.(ColourNames{i})(:, 1)]);
end

end
