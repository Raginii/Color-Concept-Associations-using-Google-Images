function uvpY = xyz2uvp(XYZ)

%Computes chromaticity coordinates u' v' and luminance
%from CIEXYZ tristimulus values
%
%USE: uvpY=xyz2uvp(XYZ)
%
%     XYZ: Nx3 matrix containing CIEXYZ tristimulus values
%     uvpY: Nx3 matrix containing [u' v' Y]


uvpY(:, 1) = 4 * XYZ(:, 1) ./ (XYZ(:, 1) + 15 * XYZ(:, 2) + 3 * XYZ(:, 3));
uvpY(:, 2) = 9 * XYZ(:, 2) ./ (XYZ(:, 1) + 15 * XYZ(:, 2) + 3 * XYZ(:, 3));
uvpY(:, 3) = XYZ(:, 2);

end
