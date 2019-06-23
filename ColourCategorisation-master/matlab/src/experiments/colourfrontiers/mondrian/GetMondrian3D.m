function RGB_3D = GetMondrian3D(RGB_original, rgb_colors, IlluminantReference, type)
%   In this funcion we will built a 3D mondrian: just draw a shadow under
%   the original mondrian.

RGB_3D = RGB_original;

[M, N, ~] = size(RGB_original);
[M_rgb, ~] = size(rgb_colors);

if type == 1
  %   Set the d65 background.
  RGB_3D(:, :, 1) = rgb_colors(M_rgb, 1);
  RGB_3D(:, :, 2) = rgb_colors(M_rgb, 2);
  RGB_3D(:, :, 3) = rgb_colors(M_rgb, 3);
elseif type == 2
  RGB_3D(:, :, 1) = 0;
  RGB_3D(:, :, 2) = 0;
  RGB_3D(:, :, 3) = 0;
end

%   Get the shadow.
shadow = 20;
new_fin_w = N - IlluminantReference + shadow;
new_fin_h = M - IlluminantReference + shadow;
new_ini_w = IlluminantReference + shadow;
new_ini_h = IlluminantReference + shadow;

RGB_3D(new_ini_h:new_fin_h, new_ini_w:new_fin_w, 1) = 0;
RGB_3D(new_ini_h:new_fin_h, new_ini_w:new_fin_w, 2) = 0;
RGB_3D(new_ini_h:new_fin_h, new_ini_w:new_fin_w, 3) = 0;

%   Get the Mondrian resized.
RGB_resized = imresize(RGB_original, [(M - 2 * IlluminantReference) (N - 2 * IlluminantReference)]);

RGB_resized(RGB_resized < 0) = 0;
RGB_resized(RGB_resized > 1) = 1;

new_fin_w = N - IlluminantReference - 1;
new_fin_h = M - IlluminantReference - 1;

RGB_3D(IlluminantReference:new_fin_h, IlluminantReference:new_fin_w, 1) = RGB_resized(:, :, 1);
RGB_3D(IlluminantReference:new_fin_h, IlluminantReference:new_fin_w, 2) = RGB_resized(:, :, 2);
RGB_3D(IlluminantReference:new_fin_h, IlluminantReference:new_fin_w, 3) = RGB_resized(:, :, 3);

end
