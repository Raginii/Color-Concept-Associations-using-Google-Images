function xyLum = XYZ2xyLum(inputXYZ)

[lin, col, pla] = size(inputXYZ);
if pla == 1
  sum = inputXYZ(:, 1) + inputXYZ(:, 2) + inputXYZ(:, 3);
  if any(sum < eps)
    sum(sum == 0) = eps;
  end
  xyLum = [inputXYZ(:, 1) ./ (sum), inputXYZ(:, 2) ./ (sum), inputXYZ(:, 2)];
elseif pla == 3
  XYZ_P = reshape(inputXYZ, lin * col, pla);
  sum= XYZ_P(:, 1) + XYZ_P(:, 2) + XYZ_P(:, 3);
  if any(any(any(sum < eps)))
    sum(sum == 0) = eps;
  end
  xyLum_P = [XYZ_P(:, 1) ./ sum; XYZ_P(:, 2) ./ sum; XYZ_P(:, 2)];
  xyLum = reshape(xyLum_P, lin, col, pla);
else
  error('wrong number of planes');
end

end
