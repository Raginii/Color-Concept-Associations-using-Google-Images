function ScaleMat = CreateScaling3(x, y, z)
%CreateScaling3 creating the scaling matrix.
%
% Inputs
%   x  the scaling factor in x direction.
%   y  the scaling factor in x direction.
%   z  the scaling factor in x direction.
%
% Outputs
%   ScaleMat  the diagonal scaling matrix 4x4.
%

ScaleMat = ...
  [
  x 0 0 0;
  0 y 0 0;
  0 0 z 0;
  0 0 0 1;
  ];

end
