function radius = find_max_rad_allowed(crs, startangle, endangle, labplane)

White_CIE1931 = crsSpaceToSpace(crs.CS_RGB, [1, 1, 1], crs.CS_CIE1931, 0);

%ref = the brightest D65 that the monitor can achieve
ref = whitepoint('d65') ./ max(whitepoint('d65')) .* White_CIE1931(3);

radius1 = FindMaximumRadiusForAngle(crs, startangle, labplane, ref);
radius2 = FindMaximumRadiusForAngle(crs, endangle, labplane, ref);

radius = min(radius1, radius2);

end

function radius = FindMaximumRadiusForAngle(crs, angle, LabPlane, ref)

radius = 0;
step = 0.5;
while true
  LabColour = pol2cart3([angle, radius, LabPlane]);
  [~, errcode] = Lab2CRSRGB(crs, [LabColour(3), LabColour(1:2)], ref, 0);
  if ~errcode
    radius = radius + step;
  else
    radius = radius - step;
    break;
  end
end

end
