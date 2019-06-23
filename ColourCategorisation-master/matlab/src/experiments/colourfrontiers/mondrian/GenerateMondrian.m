function [mondrianmeanlum, RGB_colors, mymondrian, palette] = GenerateMondrian ...
  (ExperimentParameters, current_angle, current_radius, theplane, startcolourname, endcolourname)

% number of samples in the mondrian background
numsamples = 200;

CRS = ExperimentParameters.CRS;
BackgroundType = ExperimentParameters.BackgroundType;

D65_XYZ = ExperimentParameters.refillum;
D65_RGB = crsSpaceToSpace(CRS.CS_CIE1931, XYZ2xyLum(D65_XYZ), CRS.CS_RGB, 0);

MondrianParameters.SquareNumber = 600;
MondrianParameters.MeanSize = 80;
MondrianParameters.ColorNumber = 36;
MondrianParameters.NameableRate = 0; % this parameter is useless
MondrianParameters.Id_ColourList = [0, 1, 0]; % indicates the list to read

frame_name = 1;
shadow_name = 2;

textposition_x = 75;
textposition_y = 30;

if BackgroundType >= 0 %make a grey background Lum = BackgroundType
  testedcolours = Lab2CRSRGB(CRS, [BackgroundType, 0, 0], ExperimentParameters.refillum);
  RGB_colors = repmat(testedcolours, numsamples, 1);
  mondrianmeanlum = BackgroundType;
elseif BackgroundType == -1 % make a greyscale mondrian
  [testedcolours, mondrianmeanlum] = sample_lab_space(CRS, numsamples, ExperimentParameters.refillum);
  testedcolours(:, 2) = 0;
  testedcolours(:, 3) = 0;
  RGB_colors = Lab2CRSRGB(CRS, testedcolours, ExperimentParameters.refillum);
elseif BackgroundType == -2 % make the normal colour mondrian
  [testedcolours, mondrianmeanlum] = sample_lab_space(CRS, numsamples, ExperimentParameters.refillum);
  RGB_colors = Lab2CRSRGB(CRS, testedcolours, ExperimentParameters.refillum);
end

[~, Colour_assignment, ~, mymondrian] = get_simple_mondrian(MondrianParameters, CRS);

for i = 1:length(Colour_assignment(:, 1))
  mymondrian(mymondrian == Colour_assignment(i, 1)) = mod(i, 250) + 5;
end

palette = zeros(256, 3);
cont = 1;
for i = 1:251
  palette(i + 4, :) = RGB_colors(cont, :);
  cont = cont + 1;
  if cont > length(RGB_colors(:, 1))
    cont = 1;
  end
end
palette(1, :) = D65_RGB;

Height = crsGetScreenHeightPixels;
Width = crsGetScreenWidthPixels;

% drawing the central patch test:
% frist we draw a black square and then the smaller color test patch.
Central_w = floor(Width * 0.5);
Central_h = floor(Height * 0.5);
Width_Central_Patch_h = 80;
Width_Central_Patch_w = 80;

ini_h = Central_h - Width_Central_Patch_h;
fin_h = Central_h + Width_Central_Patch_h;
ini_w = Central_w - Width_Central_Patch_w;
fin_w = Central_w + Width_Central_Patch_w;

mymondrian(ini_h:fin_h, ini_w:fin_w) = ExperimentParameters.Black_palette_name;

% TODO: make it a parameter for the function
% do we want a black border?
offset_black_patch_frame = 0;
ini_h = ini_h + offset_black_patch_frame;
fin_h = fin_h - offset_black_patch_frame;
ini_w = ini_w + offset_black_patch_frame;
fin_w = fin_w - offset_black_patch_frame;

mymondrian(ini_h:fin_h, ini_w:fin_w) = ExperimentParameters.Central_patch_name;
startingLabcolour = Lab2CRSRGB(CRS, pol2cart3([current_angle, current_radius, theplane], 1), ExperimentParameters.refillum); %D65_RGB*0.5;
palette(ExperimentParameters.Central_patch_name, :) = startingLabcolour;

% drawing the white frame and the shadow.
offline_h = 80;
offline_w = offline_h;

% TODO: make it a parameter
% do we need a shadow
shadow_width = 0;
shadow_offset = 0; %this should be smaller than offline_h

mymondrian(1:Height, 1:offline_w) = frame_name;
mymondrian(1:Height, Width - offline_w:Width) = frame_name;
mymondrian(1:offline_h, 1:Width) = frame_name;
mymondrian(Height - offline_h:Height, 1:Width) = frame_name;
mymondrian(offline_h + shadow_offset:Height - offline_h + shadow_offset, Width-offline_w:Width-offline_w + shadow_width) = shadow_name;
mymondrian(Height - offline_h:Height - offline_h + shadow_width, offline_w + shadow_offset:Width-offline_w + shadow_width) = shadow_name;

crsPaletteSet(palette');
crsSetDrawPage(1);
crsDrawMatrixPalettised(mymondrian);
crsSetDisplayPage(1);

crsDrawString([-(Width / 2 - textposition_x), Height / 2 - textposition_y], startcolourname);
crsDrawString([ (Width / 2 - textposition_x), Height / 2 - textposition_y], endcolourname);

end
