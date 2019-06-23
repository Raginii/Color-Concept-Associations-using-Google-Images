function XYZ = xyLum2XYZ(xyLum)
% XYZ = xyLum2XYZ(xyLum)
% Compute tristimulus coordinates from
% chromaticity and luminance.

[lin, col, pla] = size(xyLum);
if pla == 3
  xyLum = reshape(xyLum, lin * col, pla);
end

z = 1 - xyLum(:, 1) - xyLum(:, 2);
xyLum(ismember(xyLum(:, 2), 0), 2) = realmin;
XYZ(:, 1) = xyLum(:, 3) .* xyLum(:, 1) ./ xyLum(:, 2);
XYZ(:, 2) = xyLum(:, 3);
XYZ(:, 3) = xyLum(:, 3) .* z ./ xyLum(:, 2);

if pla == 3
  XYZ = reshape(XYZ, lin, col, pla);
end

end
