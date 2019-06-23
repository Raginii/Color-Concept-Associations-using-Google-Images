classdef ColourEllipsoidFittingParams
  %ColourEllipsoidFittingParams  wrapper class for the parameters of
  %                              ellipsoid fitting.
  
  properties
    colour
    AxesDeviation   = [1, 1, 1];
    EstimatedAxes   = [1, 1, 1];
    MinAxes         = [-inf, -inf, -inf];
    MaxAxes         = [inf, inf, inf];
    CentreDeviation = [1, 1, 1];
    EstimatedCentre = [0, 0, 0];
    MinCentre       = [-inf, -inf, -inf];
    MaxCentre       = [inf, inf, inf];
    EstimatedAngles = [0, 0, 0];           % in degrees counterclockwise
    MinAngle        = [0, 0, 0];
    MaxAngle        = [pi, pi, pi];
  end
  
  methods
    function obj = ColourEllipsoidFittingParams(colour)
      obj.colour = colour;
    end
  end
  
end
