function TransMat = CreateTranslation3(x, y, z)
%CreateTranslation3 create translation matrix in 3D.
%
% Inputs
%   x  the translation in x direction.
%   y  the translation in x direction.
%   z  the translation in x direction.
%
% Outputs
%   TransMat  the translation matrix 4x4.
%

TransMat = ...
  [
  1 0 0 x;
  0 1 0 y;
  0 0 1 z;
  0 0 0 1;
  ];

end
