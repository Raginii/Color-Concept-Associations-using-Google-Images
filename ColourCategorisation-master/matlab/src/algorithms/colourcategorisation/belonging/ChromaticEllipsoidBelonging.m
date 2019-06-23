function belonging = ChromaticEllipsoidBelonging(InputImage, ColourEllipsoids)
%ChromaticEllipsoidBelonging Summary of this function goes here
%   Detailed explanation goes here

belonging = AllEllipsoidsEvaluateBelonging(InputImage, ColourEllipsoids(1:8, :));

end
