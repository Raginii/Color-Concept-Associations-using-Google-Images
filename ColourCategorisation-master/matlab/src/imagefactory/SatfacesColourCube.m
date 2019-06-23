function [WcsColourTable, GroundTruth] = SatfacesColourCube(MakeOutputImage)
%SatfacesColourCube  returns ground truth of xkcd colour naming exmerinet.
%   Explanation http://blog.xkcd.com/2010/05/03/color-survey-results/
%
% inputs
%   MakeOutputImage  if specified as 'true' the output will be a matrix of
%                    size 512x384. if soecified as 'false' the output is a
%                    vector.
%
% outputs
%   WcsColourTable   RGB values of the tested colours.
%   GroundTruth      the probability map of eleven focal colours.
%

if nargin < 1
  MakeOutputImage = false;
end

SatfacesMat = load('satfaces.mat');
[WcsColourTable, GroundTruth] = ColourStruct2MatChans(SatfacesMat.ColourPoints);

if MakeOutputImage
  WcsColourTable = reshape(WcsColourTable, 512, 384, 3);
  GroundTruth = reshape(GroundTruth, 512, 384, 11);
end

end
