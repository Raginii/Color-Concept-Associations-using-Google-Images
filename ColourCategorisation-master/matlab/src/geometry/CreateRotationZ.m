function RotationMat = CreateRotationZ(alpha)
%CreateRotationZ create rotation matrix for the Z direction
%   Explanation http://en.wikipedia.org/wiki/Rotation_matrix
%
% Inputs
%   alpha  the rotation angle.
%
% Outputs
%   RotationMat  the rotation matrix 4x4.
%

s = sin(alpha);
c = cos(alpha);
RotationMat = ...
  [
  c -s  0  0;
  s  c  0  0;
  0  0  1  0;
  0  0  0  1;
  ];

end
