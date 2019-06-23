function [RGBcolour, theerrors] = Lab2CRSRGB(crs, labcolour, ref, warn_me)
% This function may return a colour vector that is not
% reproducable on the VSG display. If this is the case, then a
% 1 ErrorCode will be returned. (i.e. ErrorCode=1).

%ref should be specified as XYX tristimulus coordinates
if nargin < 4 || isempty(warn_me)
  warn_me = 0;
end
if nargin < 3
  White_CIE1931 = crsSpaceToSpace(crs.CS_RGB , [1, 1, 1], crs.CS_CIE1931, 0);
  
  %ref = the brightest D65 that the monitor can achieve
  ref = whitepoint('d65') .* White_CIE1931(3);
end

[lin, col, pla] = size(labcolour);
if pla == 3
  labcolour = reshape(labcolour, lin * col, pla);
  junkxyLum = XYZ2xyLum(Lab2XYZ(labcolour, ref));
  [RGBcolour, theerrors] = crsSpaceToSpace(repmat(crs.CS_CIE1931, lin * col, 1), junkxyLum, repmat(crs.CS_RGB, lin * col, 1), zeros(lin * col, 1));
elseif pla == 1
  junkxyLum = XYZ2xyLum(Lab2XYZ(labcolour, ref));
  [RGBcolour, theerrors] = crsSpaceToSpace(ones(lin, 1) * crs.CS_CIE1931, junkxyLum, ones(lin, 1) * crs.CS_RGB, zeros(lin, 1));
end

theerrors = (theerrors > 0); %to change the errorcodes from negatives to ones
% I do not know why the last command is not working as the CRS help says.
% It should give negative values instead of positive!!
if warn_me
  if min(theerrors(:)) == 1
    disp('Colour not reproducible by the current monitor');
  end
end

if pla == 3
  RGBcolour = reshape(RGBcolour, lin, col, pla);
end

end
