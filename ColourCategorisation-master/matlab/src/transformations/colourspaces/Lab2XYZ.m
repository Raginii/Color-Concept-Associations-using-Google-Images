function xyz = Lab2XYZ(lab, WhiteReference)
% XYZ = Lab2XYZ(Lab,whiteXYZ)
%
% Convert Lab to XYZ, given the XYZ coordinates of
% the white point.
%

if nargin < 2
  % white point of D65
  WhiteReference = [0.950170, 1.000000, 1.088130];
end

xyz = applycform(lab, makecform('lab2xyz', 'WhitePoint', WhiteReference));

end
