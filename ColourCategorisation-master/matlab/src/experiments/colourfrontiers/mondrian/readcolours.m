function [Nameable_Colours, No_Nameable_Colours] = readcolours(CRS, list_id, nameable, no_nameable, ExperimentParameters, Illum_Shift)
%   In this function we don't choose random colours from a list, we only
%   load a colours list. After all, the way we construct the squares
%   mondrians is condidion enought to satisfy aleatorian mondrians(?).
%   Argument's description:
%   Output variables:
%
%   Colour codification:   [L a b Color_id Nameable_id]
%   Nameable Identity:
%   1 - Nameable
%   2 - No nameable
%
%   Color Identity Nameable:
%   1 - black
%   2 - white
%   3 - red
%   4 - green
%   5 - yellow
%   6 - blue
%   7 - brown
%   8 - pink
%   9 - purple
%   10 - orange
%   11 - gray
%
%   Color Identity No Nameable:
%   12 - Brown - Red
%   13 - Red - Pink
%   14 - Pink - Purple
%   15 - Purple - Blue
%   16 - Blue - Green
%   17 - Green - Brown
%   18 - Yellow - Orange
%   19 - Orange - Red
%   20 - Green - Yellow
%   21 - Orange - Pink

%   Berlin & Kay  & Sturges & Whitfield Nameable Colours.
if list_id(2) == 1
  %  9*6 = 54;
  Nameable_Colours = [
    %   Red
    36	59.51	30.17		3	1
    36	49.53	28.41		3	1
    36	40.58	15.46		3	1
    36	45	15		3	1
    58	44.54	21.5		3	1
    58	49.53	22		3	1
    
    %   Orange
    58	44.69	79.79		10	1
    58	31.5	57.28		10	1
    58	33.3	43.67		10	1
    58	25	35		10	1
    81	33.3	45		10	1
    81	35	50		10	1
    
    %   Brown
    36	18.18	30.27		7	1
    36	13.07	33.61		7	1
    36	14.81	21.6		7	1
    36	20	40		7	1
    36	23.33	50		7	1
    36	25	45		7	1
    
    %   Yellow
    81	7.28	109.12		5	1
    81	1.65	72.03   	5	1
    81	3.35	56.36		5	1
    81	2	50		5	1
    58	3	50		5	1
    81	0	46		5	1
    
    %   Green
    58	-52.69	9.7		4	1
    58	-38.09	22.89		4	1
    58	-22.6	24.65		4	1
    58	-21.41	14.72		4	1
    36	-38.09	22.89		4	1
    81	-20	20		4	1
    
    %   Blue
    58	-3.41	-48.08		6	1
    58	-12.92	-27.22		6	1
    58	-9.61	-18.44		6	1
    58	-16.44	-30		6	1
    36	-5	-30		6	1
    81	-20	-20		6	1
    
    %   Purple
    36	23	-40		9	1
    36	20	-33		9	1
    58	20	-30		9	1
    58	30	-40		9	1
    81	20	-25		9	1
    81	25	-27		9	1
    
    %   Pink
    36	43	-7		8	1
    36	45	-8		8	1
    58	30	-3		8	1
    58	42	-5		8	1
    81	37	7		8	1
    81	50	10		8	1
    
    %   Grey
    58	-0.03	0.04		11	1
    58	-0.04	0.04		11	1
    58	-1.23	1.94		11	1
    58	-3.95	1.42		11	1
    58	2	2		11	1
    58	0	0		11	1
    ];

No_Nameable_Colors_uvp =   [
  0.162   0.465   9       15  0 % Blue	Purple
  0.176   0.347   9       15  0 % Blue	Purple
  0.260   0.528   9       17  0 % Brown	Green
  0.236   0.516   9       17  0 % Brown	Green
  0.200   0.413   9       16  0 % Green	Blue
  0.140   0.432   9       16  0 % Green	Blue
  0.298   0.48    9       13  0 % Pink	Red
  0.321   0.498   9       13  0 % Pink	Red
  0.228   0.407   9       14  0 % Purple	Pink
  0.261   0.379   9       14  0 % Purple	Pink
  0.305   0.489   9       12  0 % Red	Brown
  0.353   0.514   9       12  0 % Red	Brown
  0.198   0.416   25.96   15  0 % Blue	Purple
  0.196   0.368   25.96   15  0 % Blue	Purple
  0.134   0.454   25.96   16  0 % Green	Blue
  0.166   0.465   25.96   16  0 % Green	Blue
  0.272   0.514   25.96   18  0 % Orange	Yellow
  0.251   0.533   25.96   18  0 % Orange	Yellow
  0.249   0.481   25.96   21 0  % Pink	Orange
  0.278   0.495   25.96   13  0 % Pink	Red
  0.207   0.434   25.96   14  0 % Purple	Pink
  0.281   0.461   25.96   14  0 % Purple	Pink
  0.214   0.519   25.96   19  0 % Red	Orange
  0.215   0.536   25.96   20  0 % Yellow	Green
  0.203   0.434   58.47   20  0 % Yellow	Green
  0.194   0.436   58.47   15  0 % Blue	Purple
  0.149   0.466   58.47   15  0 % Blue	Purple
  0.144   0.479   58.47   16  0 % Green	Blue
  0.173   0.478   58.47   16  0 % Green	Blue
  0.229   0.502   58.47   18  0 % Orange	Yellow
  0.232   0.522   58.47   18  0 % Orange	Yellow
  0.237   0.499   58.47   21 0  % Pink	Orange
  0.246   0.497   58.47   21 0  % Pink	Orange
  0.224   0.448   58.47   14  0 % Purple	Pink
  0.226   0.441   58.47   14  0 % Purple	Pink
  0.209   0.508   58.47   20  0 % Yellow	Green
  ];

aux = XYZ2Lab(uvp2xyz(No_Nameable_Colors_uvp(:, 1:3)), whitepoint('d65')*100);
No_Nameable_Colors_uvp(:, 1:3)= aux;
No_Nameable_Colours = No_Nameable_Colors_uvp;

end

%   Our Colours.
if list_id(3) == 1
  
  %   We choose nameable color from Berlin & Kay Nameable Colors for English
  %   speackers. We modified these colors in order they fall inside the gamut
  %   of the CRT through a shfit of 20 units in Lab Color Space. These are
  %   the rules that we followed:
  
  %   Set of shiftable colors by red illuminant.
  if ExperimentParameters.Illuminant_Red
    Nameable_Colours = [
      %   BROWN
      30.77	18.18	30.27 7   1
      %   ORANGE
      58   30  50          10   1
      %   GREEN
      53.7012  -45.3301   12.1956  4   1
      %   BLUE
      52.5187   -5.0095  -38.8000  6   1
      %   GREY
      51  0   0   11  1
      
      %   GREEN
      81  -70  60   4 1
      ];
    
    No_Nameable_Colours =  [
      %   Blue - Purple
      36	7	-24.00  15  0
      %   Green - Blue
      36	-19.08	-14.19  16  0
      
      %   Yellow - Orange
      58	20.5	46.98  18  0
      %   Red - Pink
      58	22.61	10.15  13  0
      %   Red - Pink
      %58	43.78	14  13  0
      
      %   Green - Yellow
      58  -5  47  20 0
      
      %   Green - Blue
      81.0000  -36.6400   -4.9700 16 0
      ];
  end
  
  %  Set of shiftable colors by green illuminant.
  if ExperimentParameters.Illuminant_Green
    Nameable_Colours = [
      
    %   BROWN
    30.77	18.18	30.27 7   1
    %   ORANGE
    58   30  50          10   1
    %   GREEN
    %53.7012  -45.3301   12.1956  4   1
    %   BLUE
    %52.5187   -5.0095  -38.8000  6   1
    %   GREY
    %51  0   0   11  1
    
    %   GREEN
    %81  -70  60   4 1
    
    ];
  
  No_Nameable_Colours =  [
    %   Blue - Purple
    36	7	-24.00  15  0
    %   Green - Blue
    36	-19.08	-14.19  16  0
    
    %   Yellow - Orange
    58	20.5	46.98  18  0
    %   Red - Pink
    58	22.61	10.15  13  0
    %   Red - Pink
    %58	43.78	14  13  0
    
    %   Green - Yellow
    58  -5  47  20 0
    
    %   Green - Blue
    81.0000  -36.6400   -4.9700 16 0
    
    ];
  end
end

if list_id(2) == 1
  
  [~, Nameable_Colours]= EraseOutGamutColors(Nameable_Colours, CRS, Illum_Shift);
  %disp(sprintf('Number of Nameable Colors erased: %d', number_of_erased_colors));
  
  [~, No_Nameable_Colours]= EraseOutGamutColors(No_Nameable_Colours, CRS, Illum_Shift);
  %disp(sprintf('Number of No Nameable Colors erased: %d', number_of_erased_colors));
  
  %   Adjust the sizes:
  if (nameable > size(Nameable_Colours(:, 1),1))
    nameable = size(Nameable_Colours(:, 1),1);
  end
  if (no_nameable > size(No_Nameable_Colours(:, 1),1))
    no_nameable = size(No_Nameable_Colours(:, 1),1);
  end
  
end

%   Write the final lists.
%   The way that we assign colors

Nameable_Colours = Nameable_Colours(1:nameable, :);
No_Nameable_Colours = No_Nameable_Colours(1:no_nameable, :);

end

function [number_of_erased_colors, Colours] = EraseOutGamutColors(Colours, CRS, Illum_Shift)
%   Erase the nameable colors that are not shiftable.
White_CIE1931 = crsSpaceToSpace(CRS.CS_RGB,[1 1 1], CRS.CS_CIE1931 , 0);
D65_XYZ = whitepoint('d65')./max(whitepoint('d65')).* White_CIE1931(3);

%   Auxiliar variables.
%   Calulate the direction of the shift.
shift_partition = 40;
Red_uv =[0.23 0.46];
illum_red_uv =[0.3463 0.4398];
vd_red_illum = illum_red_uv - Red_uv;
vd_red_illum = vd_red_illum / shift_partition;
white_xyz = whitepoint('d65')*100;
lab_colors = Colours(:, 1:3);

%   Translate lab colors to uvp.
uvp_colors = xyz2uvp(Lab2XYZ(lab_colors, white_xyz));

%   Illuminate uvp colors for green and red illuminats(shift them).
uvp_colors_red(:, 1)= uvp_colors(:, 1)+ Illum_Shift * vd_red_illum(1);
uvp_colors_red(:, 2)= uvp_colors(:, 2)+ Illum_Shift * vd_red_illum(2);
uvp_colors_red(:, 3)= uvp_colors(:, 3);

uvp_colors_green(:, 1)= uvp_colors(:, 1)- Illum_Shift * vd_red_illum(1);
uvp_colors_green(:, 2)= uvp_colors(:, 2)- Illum_Shift * vd_red_illum(2);
uvp_colors_green(:, 3)= uvp_colors(:, 3);

%   Translate uvp illuminated colors to lab.
lab_colors_red = XYZ2Lab(uvp2xyz(uvp_colors_red), white_xyz);
lab_colors_green = XYZ2Lab(uvp2xyz(uvp_colors_green), white_xyz);

%   Translate lab values to rgb values.
[~, ErrorCode_1]= Lab2CRSRGB(CRS, lab_colors_red, D65_XYZ);
[~, ErrorCode_2]= Lab2CRSRGB(CRS, lab_colors_green, D65_XYZ);

%   Check the transformation error codes.
ind = zeros(size(ErrorCode_1, 1), 1);
for i = 1:size(ErrorCode_1, 1)
  
  if(ErrorCode_1(i)~= 0)
    ind(i)= 1;
  end
  
  if(ErrorCode_2(i)~= 0)
    ind(i)= 1;
  end
  
end
indexs = find(ind == 1);
number_of_erased_colors = length(indexs);

%   Erase the colors.
if(number_of_erased_colors > 0)
  Colours(indexs, :)=[];
end

end
