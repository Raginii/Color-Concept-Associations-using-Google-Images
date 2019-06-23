function RotationMat = CreateRotationX(alpha)
%CreateRotationX create rotation matrix for the X direction
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
  1  0  0  0;
  0  c -s  0;
  0  s  c  0;
  0  0  0  1;
  ];

end
