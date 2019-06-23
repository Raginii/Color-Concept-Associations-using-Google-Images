function belonging = AchromaticEllipsoidBelonging(InputImage, ColourEllipsoids)
%AchromaticEllipsoidBelonging Summary of this function goes here
%   Detailed explanation goes here

belonging = AllEllipsoidsEvaluateBelonging(InputImage, ColourEllipsoids(9:11, :));

end
