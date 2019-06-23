function [RGB_image, Colour_assignment, rgb_colors, mask] = get_simple_mondrian(MondrianParameters, CRS)

%   PARAMETERS MODIFICATION:
Colours = 0;
order = 0;
mondrian_index = 1;
IlluminantShift = 0;

% TODO: get the size authomatically from the monitor
ImageParameters.Height = 600;
ImageParameters.Width = 800;
ImageParameters.center_h = ImageParameters.Height / 2;
ImageParameters.center_w = ImageParameters.Width / 2;

MondrianParameters.First_rate_Border = 0.4000;
MondrianParameters.Second_rate_Border = 0.8000;
MondrianParameters.first_level_rate = 0.4000;
MondrianParameters.second_level_rate = 0.3000;
MondrianParameters.third_level_rate = 0.3000;

ExperimentParameters.Illuminant_Red = 1;
ExperimentParameters.Illuminant_Green = 0;

%   Auxiliar variables & Initializing.
Colour_assignment = [0, 0, 0, 0, 0, 0];
mask = zeros(ImageParameters.Height, ImageParameters.Width);

%   FIRST PART: GENERATE THE 'SQUARE' LIST.
listofsquares = GenerateMondrianSquares(ImageParameters, MondrianParameters);

Inicial_num_of_squares = size(listofsquares, 1);

%   Get an auxiliar image where squares are over-settled.
for i = 1:Inicial_num_of_squares
  %   Square definition.
  pos_w = listofsquares(i, 1);
  pos_h = listofsquares(i, 2);
  size_w = listofsquares(i, 3);
  size_h = listofsquares(i, 4);
  
  w_ini = pos_w - size_w;
  w_fin = pos_w + size_w;
  h_ini = pos_h - size_h;
  h_fin = pos_h + size_h;
  
  %   Check the square.
  if w_ini < 1
    w_ini = 1;
  end
  if h_ini < 1
    h_ini = 1;
  end
  if w_fin > ImageParameters.Width
    w_fin = ImageParameters.Width;
  end
  if h_fin > ImageParameters.Height
    h_fin = ImageParameters.Height;
  end
  
  %   Drawing the square.
  mask(h_ini:h_fin, w_ini:w_fin) = i;
end

%   Obs. Not all squares survive!
%   Write the final square list.
%   Read the mask matrix.

Border_1 = ImageParameters.center_h * MondrianParameters.First_rate_Border;
Border_2 = ImageParameters.center_h * MondrianParameters.Second_rate_Border;

cont_1 = 0;
cont_2 = 0;
cont_3 = 0;
cont_4 = 0;

for i = 1:Inicial_num_of_squares
  [row, column] = find(mask == i);
  totalpixels = length(row);
  if totalpixels > 0
    %   Basic Features: Get the region center.
    center_w = round(sum(column) / totalpixels);
    center_h = round(sum(row) / totalpixels);
    
    %   Distance from center.
    Aux = ((ImageParameters.center_h - center_h) ^ 2 + (ImageParameters.center_w - center_w) ^ 2) ^ 0.5;
    
    %   Classification from distance.
    if Aux <= Border_1
      cont_1 = cont_1 + 1;
      First_listofsquares(cont_1, :) = [i, totalpixels];
    elseif Aux > Border_1 && Aux <= Border_2
      cont_2 = cont_2 + 1;
      Second_listofsquares(cont_2, :) = [i, totalpixels];
    else
      cont_3 = cont_3 + 1;
      Third_listofsquares(cont_3, :) = [i, totalpixels];
    end
    cont_4 = cont_4 + 1;
    New_listofsquares(cont_4, :) = listofsquares(i, :);
  end
end
clear listofsquares;
Final_num_of_squares = cont_1 + cont_2 + cont_3;

%   Check empty zones!!!    mask == 0!!
%   The empty zones will appear as black.
%   Solution: will build a new 'square' with his own identifier.

Mondrian_Statistics.Final_num_of_squares = Final_num_of_squares;
Mondrian_Statistics.DarkPixels = 0;

[row, column] = find (mask == 0);
totaldarkpixels = length (row);
if totaldarkpixels > 0
  Mondrian_Statistics.Final_num_of_squares = Inicial_num_of_squares + 1;
  %   eliminar for...
  for k = 1 : 1 : totaldarkpixels
    mask(row(k), column(k)) = Mondrian_Statistics.Final_num_of_squares;
  end
  cont_3 = cont_3 + 1;
  Third_listofsquares (cont_3, :) = [Mondrian_Statistics.Final_num_of_squares totalpixels];
  Mondrian_Statistics.DarkPixels = totaldarkpixels;
end

%   The problem is not totally solved, we must check that this pixels are
%   residual in the image, because this new square will not have a
%   a coherent center of mass(next step).
%   It is just a 'perceptual' solution not 'computacional'.

if cont_1 > 0
  listofsquares.first = First_listofsquares;
else
  listofsquares.first = 0;
end
if cont_2 > 0
  listofsquares.second = Second_listofsquares;
else
  listofsquares.first = 0;
end
if cont_3 > 0
  listofsquares.third = Third_listofsquares;
else
  listofsquares.first = 0;
end

%   GENERATE COLOURS.
NameableColoursNumber = round(MondrianParameters.ColorNumber * MondrianParameters.NameableRate);
NoNameableColoursNumber = MondrianParameters.ColorNumber - NameableColoursNumber;

if mondrian_index == 1
  [Nameable_Colours, No_Nameable_Colours] = readcolours(CRS, MondrianParameters.Id_ColourList, NameableColoursNumber, NoNameableColoursNumber, ExperimentParameters, IlluminantShift);
  
  Colours = [Nameable_Colours(:, 1:3); No_Nameable_Colours(:, 1:3)];
  NameableColoursNumber = size(Nameable_Colours, 1);
  NoNameableColoursNumber = size(No_Nameable_Colours, 1);
  %   en un futur eliminar aquesta transici�...motivada per l'evoluci�
  %   del codi.
  vv = [Nameable_Colours(:, 5); No_Nameable_Colours(:, 5)];
  cc = [Nameable_Colours(:, 4); No_Nameable_Colours(:, 4)];
  order = ones (length(vv), 2);
  order(:, 2) = vv; % store nameability classification.
  order(:, 1) = cc; % store color's classification.
end

%   Store this values in order to put them in the results file.
Mondrian_Statistics.NameableColoursNumber = NameableColoursNumber;
Mondrian_Statistics.NoNameableColoursNumber = NoNameableColoursNumber;

if (MondrianParameters.NameableRate == 1 || MondrianParameters.NameableRate == 0)
  
  if (MondrianParameters.NameableRate == 0)
    id = 0;
    color_type = 'No_Nameable';
  else
    id = 1;
    color_type = 'Nameable';
  end;
  
  index = 1;
  
  %   First ring.
  for k = 1 : 1 : cont_1
    [Colour, index, colour_id] = Get_Next_Colour(index, Colours, order, color_type);
    Colour_assignment(k, :) = [listofsquares.first(k, 1), Colour, id, colour_id];
  end
  
  %   Second ring.
  j = 1;
  for k = cont_1+1 : 1 : cont_1+cont_2
    [Colour, index, colour_id] = Get_Next_Colour(index, Colours, order, color_type);
    Colour_assignment(k, :) = [listofsquares.second(j, 1), Colour, id, colour_id];
    j = j + 1;
  end
  
  %   Third ring.
  j = 1;
  for k = cont_1+cont_2+1 : 1 : cont_1+cont_2+cont_3
    [Colour, index, colour_id] = Get_Next_Colour(index, Colours, order, color_type);
    Colour_assignment(k, :) = [listofsquares.third(j, 1), Colour, id, colour_id];
    j = j + 1;
  end
  
else
  
  nameable_index = 0;
  no_nameable_index = 0;
  if (cont_1 > 0)
    [Colour_assignment, nameable_index,  no_nameable_index] = Assign_Colours(1, Colour_assignment, listofsquares.first, First_Ring_Area, Colours, order, nameable_index, no_nameable_index, MondrianParameters.NameableRate);
  end
  if (cont_2 > 0)
    [Colour_assignment, nameable_index,  no_nameable_index] = Assign_Colours(2, Colour_assignment, listofsquares.second, Second_Ring_Area, Colours, order, nameable_index, no_nameable_index, MondrianParameters.NameableRate);
  end
  if (cont_3 > 0)
    [Colour_assignment, ~,  ~]  = Assign_Colours(3, Colour_assignment, listofsquares.third, Third_Ring_Area, Colours, order, nameable_index, no_nameable_index, MondrianParameters.NameableRate);
  end
  
end

%   Get Mondrian Statistics!
[Mondrian_Statistics.NameablePixels, Mondrian_Statistics.NoNameablePixels, Mondrian_Statistics.ColoursRate, Mondrian_Statistics.ColorMean] = Check_Mondrian_Colors (Colour_assignment, mask, ImageParameters);


Illuminant_color = [80, 0, 0];
Illuminant_Identity = MondrianParameters.SquareNumber + 10;

Colour_assignment(length(Colour_assignment(:, 1)) + 1, :) = [Illuminant_Identity Illuminant_color -1 1];
[RGB_image, rgb_colors] = draw_mondrian(mask, Colour_assignment, CRS);

% frame size in pixels: IlluminantReference
IlluminantReference = 80;
type = 1;

RGB_image = GetMondrian3D(RGB_image, rgb_colors, IlluminantReference, type);

end

function [RGB, rgb_colors] = draw_mondrian(mask, Colour_assignment, CRS)

White_CIE1931 = crsSpaceToSpace(CRS.CS_RGB, [1 1 1], CRS.CS_CIE1931 , 0);
D65_XYZ = whitepoint('d65')./max(whitepoint('d65')) .* White_CIE1931(3);
%   In this function we build and RGB matrix.

%   Getting parameters.
[m, n] =  size (mask);
[num_colors, ~] = size (Colour_assignment);
lab = [Colour_assignment(:,2) Colour_assignment(:,3) Colour_assignment(:,4)];

%   Lab to RGB transformation of colors. We use the CRS functions in
%   the final step to avoid(are already implemented in CRS functions) control CRT corrections.
rgb = Lab2CRSRGB(CRS, lab,D65_XYZ);

%   Preallocating memory.
R_matrix = zeros (m, n);
G_matrix = zeros (m, n);
B_matrix = zeros (m, n);

%   Build the matrix.
for i = 1:num_colors
  %   Get the region pixels with identifier stored in Colour_assignment(:,1).
  ind = find(mask == Colour_assignment (i, 1));
  R_matrix(ind) = rgb(i, 1);
  G_matrix(ind) = rgb(i, 2);
  B_matrix(ind) = rgb(i, 3);
end

RGB(:, :, 1) = R_matrix;
RGB(:, :, 2) = G_matrix;
RGB(:, :, 3) = B_matrix;
rgb_colors = rgb;

end

function [Colour_assignment_final, nameable_index,  no_nameable_index] = Assign_Colours(list_id, Colour_assignment_final, listofsquares, Total_Area, Colours, order, nameable_index, no_nameable_index, Nameable_Rate)
%   This function assign colors to squares in function of center
%   squares distance to the image center. The colors first given are
%   nameables colors according to the nameable rate, after that,
%   nonameable colors are assigned.

num_squares = length (listofsquares(:, 1));
Nameable_area = Total_Area * Nameable_Rate;

%   Sort squares from size.
temp_vect_1 = listofsquares(:, 2);  %   area
temp_vect_2 = listofsquares(:, 1);  %   identificator
[vect_ordered, permutation] = sort(temp_vect_1, 'descend');
temp_vect_2 = temp_vect_2(permutation);
temporal_sq_list = [vect_ordered temp_vect_2];   % area identif.


%   Assign Nameable Colours until nameable rate is get.
cont = 0;
num_pixels = 0;
while (num_pixels < Nameable_area && cont < num_squares)
  
  cont = cont + 1;
  [Colour, nameable_index, colour_id] = Get_Next_Colour(nameable_index, Colours, order, 'Nameable');
  Colour_assignment(cont, :) = [temporal_sq_list(cont, 2), Colour, 1, colour_id];
  
  %   comprovem iteraci�:
  num_pixels = num_pixels + temporal_sq_list(cont, 1);
end

%   Assign NoNameable Colours
for i = (cont+1) : num_squares
  [Colour, no_nameable_index] = Get_Next_Colour(no_nameable_index, Colours, order, 'No_Nameable');
  Colour_assignment(i, :) = [temporal_sq_list(i, 2), Colour, 0, colour_id];
end

%   Fullfilment rate

if (list_id == 1 )
  Colour_assignment_final = Colour_assignment;
else
  Colour_assignment_final = [Colour_assignment_final; Colour_assignment];
end

end

function [Colour, index, colour_id] = Get_Next_Colour(index, Colours, order, Colour_type)
%   Given a colours list(Colours) we get the next colour from it that
%   mathces Colour_type. The Colour_type of the colours list is stored
%   in the order array.

max_index = length (Colours(:, 1));

if (strcmp('Nameable', Colour_type))
  index = index + 1;
  if (index > max_index)
    index = 1;
  end
  while (order(index, 2) ~= 1)
    index = index + 1;
    if (index > max_index)
      index = 1;
    end
  end
elseif (strcmp('No_Nameable', Colour_type))
  index = index + 1;
  if (index > max_index)
    index = 1;
  end
  while (order(index, 2) ~= 0)
    index = index + 1;
    if (index > max_index)
      index = 1;
    end
  end
else
  disp('Get_Next_Colour: Wrong Arguments!!');
end

%   The selected colour.
Colour = Colours(index, :);
colour_id = order(index, 1);

end

function [nameable_pixels, no_nameable_pixels, ColoursRate, ColorMean] = Check_Mondrian_Colors(Colour_assignment, mask, Image_Parameters)
%  This function checks if the mondrian rates are the demanded
%  ones. It works as a pixel coord and not as a square coord.

n = length (Colour_assignment(:, 1));
nameable_pixels = 0;
no_nameable_pixels = 0;

%   Colour's Rate Acumulator.
%   21 is the number of codificated colors
ColoursRate = zeros(21, 1);
ColorMean = zeros (3, 1);

for i = 1:n
  index = Colour_assignment(i, 1);
  is_nameable = Colour_assignment(i, 5);
  pixels_num = length(find (mask == index));
  
  ColoursRate(Colour_assignment(i, 6)) = ColoursRate(Colour_assignment(i, 6)) + pixels_num;
  
  if (is_nameable == 1)
    nameable_pixels = nameable_pixels + pixels_num;
  else
    no_nameable_pixels = no_nameable_pixels + pixels_num;
  end
  
  ColorMean(1) = ColorMean(1) + pixels_num * Colour_assignment(i, 2);
  ColorMean(2) = ColorMean(2) + pixels_num * Colour_assignment(i, 3);
  ColorMean(3) = ColorMean(3) + pixels_num * Colour_assignment(i, 4);
end

aux = Image_Parameters.Width * Image_Parameters.Height;

ColoursRate = ColoursRate ./ aux;
ColorMean = ColorMean ./ aux;

end
