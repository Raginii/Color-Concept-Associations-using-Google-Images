function RotationMat = CreateRotationY(alpha)
%CreateRotationY create rotation matrix for the Y direction
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
   c  0  s  0;
   0  1  0  0;
  -s  0  c  0;
   0  0  0  1;
  ];

end
