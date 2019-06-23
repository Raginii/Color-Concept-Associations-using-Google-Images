function [ColourFrontiers, ColourFrontiersCentre] = OrganiseExperimentFrontiers(FilePath, plotme, XYZ2lsYChoise, BackgroundType)
%OrganiseExperimentFrontiers  the colour frontier experiment data.
%
% inputs
%   FilePath        the path to the original experiment.
%   plotme          if true it is plotted.
%   XYZ2lsYChoise   the choise of lsY space, if false lab is used.
%   BackgroundType  0 = both, 1 = chromatic, 2 = achromatic
%
% outputs
%   ColourFrontiers        colour frontier points.
%   ColourFrontiersCentre  the centre of the colour space.
%

if nargin < 2
  plotme = 0;
end
if nargin < 3
  XYZ2lsYChoise = 'evenly_ditributed_stds';
end
if nargin < 4
  BackgroundType = 0;
end

RawDataMat = load(FilePath);
saturated_chrom_Lab = RawDataMat.saturated_chrom_Lab;
saturated_achrom_Lab = RawDataMat.saturated_achrom_Lab;
unsaturated_chrom_Lab = RawDataMat.unsaturated_chrom_Lab;
unsaturated_achrom_Lab = RawDataMat.unsaturated_achrom_Lab;

% reference white used in the experiments
WhiteReference = RawDataMat.WhiteReference;

ColourFrontiers = struct();
if ~XYZ2lsYChoise
  ColourFrontiersCentre = [128, 0, 0];
else
  ColourFrontiersCentre = XYZ2lsY(Lab2XYZ([128, 0, 0],   WhiteReference), XYZ2lsYChoise);
end
borders = {};

% colour objects
ColourFrontiers.black  = ColourCategory('black');
ColourFrontiers.blue   = ColourCategory('blue');
ColourFrontiers.brown  = ColourCategory('brown');
ColourFrontiers.green  = ColourCategory('green');
ColourFrontiers.grey   = ColourCategory('grey');
ColourFrontiers.orange = ColourCategory('orange');
ColourFrontiers.pink   = ColourCategory('pink');
ColourFrontiers.purple = ColourCategory('purple');
ColourFrontiers.red    = ColourCategory('red');
ColourFrontiers.yellow = ColourCategory('yellow');
ColourFrontiers.white  = ColourCategory('white');

if ~XYZ2lsYChoise
  %% saturated frontiers (coloured background)
  lsY_36_G_B_c   = saturated_chrom_Lab(:, 1:3);
  lsY_36_B_Pp_c  = saturated_chrom_Lab(:, 4:6);
  lsY_36_Pp_Pk_c = saturated_chrom_Lab(:, 7:9);
  lsY_36_Pk_R_c  = saturated_chrom_Lab(:, 10:12);
  lsY_36_R_Br_c  = saturated_chrom_Lab(:, 13:15);
  lsY_36_Br_G_c  = saturated_chrom_Lab(:, 16:18);
  
  lsY_58_G_B_c   = saturated_chrom_Lab(:, 19:21);
  lsY_58_B_Pp_c  = saturated_chrom_Lab(:, 22:24);
  lsY_58_Pp_Pk_c = saturated_chrom_Lab(:, 25:27);
  lsY_58_Pk_R_c  = saturated_chrom_Lab(:, 28:30);
  lsY_58_R_O_c   = saturated_chrom_Lab(:, 31:33);
  lsY_58_O_Y_c   = saturated_chrom_Lab(:, 34:36);
  lsY_58_Y_G_c   = saturated_chrom_Lab(:, 37:39);
  
  lsY_81_G_B_c   = saturated_chrom_Lab(:, 40:42);
  lsY_81_B_Pp_c  = saturated_chrom_Lab(:, 43:45);
  lsY_81_Pp_Pk_c = saturated_chrom_Lab(:, 46:48);
  lsY_81_Pk_O_c  = saturated_chrom_Lab(:, 49:51);
  lsY_81_O_Y_c   = saturated_chrom_Lab(:, 52:54);
  lsY_81_Y_G_c   = saturated_chrom_Lab(:, 55:57);
  
  %% saturated frontiers (achromatic background)
  lsY_36_G_B_a   = saturated_achrom_Lab(:, 1:3);
  lsY_36_B_Pp_a  = saturated_achrom_Lab(:, 4:6);
  lsY_36_Pp_Pk_a = saturated_achrom_Lab(:, 7:9);
  lsY_36_Pk_R_a  = saturated_achrom_Lab(:, 10:12);
  lsY_36_R_Br_a  = saturated_achrom_Lab(:, 13:15);
  lsY_36_Br_G_a  = saturated_achrom_Lab(:, 16:18);
  
  lsY_58_G_B_a   = saturated_achrom_Lab(:, 19:21);
  lsY_58_B_Pp_a  = saturated_achrom_Lab(:, 22:24);
  lsY_58_Pp_Pk_a = saturated_achrom_Lab(:, 25:27);
  lsY_58_Pk_R_a  = saturated_achrom_Lab(:, 28:30);
  lsY_58_R_O_a   = saturated_achrom_Lab(:, 31:33);
  lsY_58_O_Y_a   = saturated_achrom_Lab(:, 34:36);
  lsY_58_Y_G_a   = saturated_achrom_Lab(:, 37:39);
  
  lsY_81_G_B_a   = saturated_achrom_Lab(:, 40:42);
  lsY_81_B_Pp_a  = saturated_achrom_Lab(:, 43:45);
  lsY_81_Pp_Pk_a = saturated_achrom_Lab(:, 46:48);
  lsY_81_Pk_O_a  = saturated_achrom_Lab(:, 49:51);
  lsY_81_O_Y_a   = saturated_achrom_Lab(:, 52:54);
  lsY_81_Y_G_a   = saturated_achrom_Lab(:, 55:57);
else
  %% saturated frontiers (coloured background)
  lsY_36_G_B_c   = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 1:3),   WhiteReference), XYZ2lsYChoise);
  lsY_36_B_Pp_c  = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 4:6),   WhiteReference), XYZ2lsYChoise);
  lsY_36_Pp_Pk_c = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 7:9),   WhiteReference), XYZ2lsYChoise);
  lsY_36_Pk_R_c  = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 10:12), WhiteReference), XYZ2lsYChoise);
  lsY_36_R_Br_c  = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 13:15), WhiteReference), XYZ2lsYChoise);
  lsY_36_Br_G_c  = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 16:18), WhiteReference), XYZ2lsYChoise);
  
  lsY_58_G_B_c   = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 19:21), WhiteReference), XYZ2lsYChoise);
  lsY_58_B_Pp_c  = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 22:24), WhiteReference), XYZ2lsYChoise);
  lsY_58_Pp_Pk_c = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 25:27), WhiteReference), XYZ2lsYChoise);
  lsY_58_Pk_R_c  = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 28:30), WhiteReference), XYZ2lsYChoise);
  lsY_58_R_O_c   = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 31:33), WhiteReference), XYZ2lsYChoise);
  lsY_58_O_Y_c   = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 34:36), WhiteReference), XYZ2lsYChoise);
  lsY_58_Y_G_c   = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 37:39), WhiteReference), XYZ2lsYChoise);
  
  lsY_81_G_B_c   = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 40:42), WhiteReference), XYZ2lsYChoise);
  lsY_81_B_Pp_c  = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 43:45), WhiteReference), XYZ2lsYChoise);
  lsY_81_Pp_Pk_c = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 46:48), WhiteReference), XYZ2lsYChoise);
  lsY_81_Pk_O_c  = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 49:51), WhiteReference), XYZ2lsYChoise);
  lsY_81_O_Y_c   = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 52:54), WhiteReference), XYZ2lsYChoise);
  lsY_81_Y_G_c   = XYZ2lsY(Lab2XYZ(saturated_chrom_Lab(:, 55:57), WhiteReference), XYZ2lsYChoise);
  
  %% saturated frontiers (achromatic background)
  lsY_36_G_B_a   = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 1:3),   WhiteReference), XYZ2lsYChoise);
  lsY_36_B_Pp_a  = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 4:6),   WhiteReference), XYZ2lsYChoise);
  lsY_36_Pp_Pk_a = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 7:9),   WhiteReference), XYZ2lsYChoise);
  lsY_36_Pk_R_a  = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 10:12), WhiteReference), XYZ2lsYChoise);
  lsY_36_R_Br_a  = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 13:15), WhiteReference), XYZ2lsYChoise);
  lsY_36_Br_G_a  = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 16:18), WhiteReference), XYZ2lsYChoise);
  
  lsY_58_G_B_a   = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 19:21), WhiteReference), XYZ2lsYChoise);
  lsY_58_B_Pp_a  = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 22:24), WhiteReference), XYZ2lsYChoise);
  lsY_58_Pp_Pk_a = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 25:27), WhiteReference), XYZ2lsYChoise);
  lsY_58_Pk_R_a  = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 28:30), WhiteReference), XYZ2lsYChoise);
  lsY_58_R_O_a   = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 31:33), WhiteReference), XYZ2lsYChoise);
  lsY_58_O_Y_a   = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 34:36), WhiteReference), XYZ2lsYChoise);
  lsY_58_Y_G_a   = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 37:39), WhiteReference), XYZ2lsYChoise);
  
  lsY_81_G_B_a   = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 40:42), WhiteReference), XYZ2lsYChoise);
  lsY_81_B_Pp_a  = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 43:45), WhiteReference), XYZ2lsYChoise);
  lsY_81_Pp_Pk_a = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 46:48), WhiteReference), XYZ2lsYChoise);
  lsY_81_Pk_O_a  = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 49:51), WhiteReference), XYZ2lsYChoise);
  lsY_81_O_Y_a   = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 52:54), WhiteReference), XYZ2lsYChoise);
  lsY_81_Y_G_a   = XYZ2lsY(Lab2XYZ(saturated_achrom_Lab(:, 55:57), WhiteReference), XYZ2lsYChoise);
end

%% unsaturated frontiers (chromatic background)

Lab_36_W_G_c  = unsaturated_chrom_Lab(:, 1:3);
Lab_36_W_B_c  = unsaturated_chrom_Lab(:, 4:6);
Lab_36_W_Pp_c = unsaturated_chrom_Lab(:, 7:9);
Lab_36_W_Pk_c = unsaturated_chrom_Lab(:, 10:12);
Lab_36_W_R_c  = unsaturated_chrom_Lab(:, 13:15);
Lab_36_W_Br_c = unsaturated_chrom_Lab(:, 16:18);

Lab_36_W_G_c(all(Lab_36_W_G_c' == 0), :) = [];
Lab_36_W_B_c(all(Lab_36_W_B_c' == 0), :) = [];
Lab_36_W_Pp_c(all(Lab_36_W_Pp_c' == 0), :) = [];
Lab_36_W_Pk_c(all(Lab_36_W_Pk_c' == 0), :) = [];
Lab_36_W_R_c(all(Lab_36_W_R_c' == 0), :) = [];
Lab_36_W_Br_c(all(Lab_36_W_Br_c' == 0), :) = [];

Lab_58_W_G_c  = unsaturated_chrom_Lab(:, 19:21);
Lab_58_W_B_c  = unsaturated_chrom_Lab(:, 22:24);
Lab_58_W_Pp_c = unsaturated_chrom_Lab(:, 25:27);
Lab_58_W_Pk_c = unsaturated_chrom_Lab(:, 28:30);
Lab_58_W_R_c  = unsaturated_chrom_Lab(:, 31:33);
Lab_58_W_O_c  = unsaturated_chrom_Lab(:, 34:36);
Lab_58_W_Y_c  = unsaturated_chrom_Lab(:, 37:39);

Lab_58_W_G_c(all(Lab_58_W_G_c' == 0), :) = [];
Lab_58_W_B_c(all(Lab_58_W_B_c' == 0), :) = [];
Lab_58_W_Pp_c(all(Lab_58_W_Pp_c' == 0), :) = [];
Lab_58_W_Pk_c(all(Lab_58_W_Pk_c' == 0), :) = [];
Lab_58_W_R_c(all(Lab_58_W_R_c' == 0), :) = [];
Lab_58_W_O_c(all(Lab_58_W_O_c' == 0), :) = [];
Lab_58_W_Y_c(all(Lab_58_W_Y_c' == 0), :) = [];

Lab_81_W_G_c  = unsaturated_chrom_Lab(:, 40:42);
Lab_81_W_B_c  = unsaturated_chrom_Lab(:, 43:45);
Lab_81_W_Pp_c = unsaturated_chrom_Lab(:, 46:48);
Lab_81_W_Pk_c = unsaturated_chrom_Lab(:, 49:51);
Lab_81_W_O_c  = unsaturated_chrom_Lab(:, 52:54);
Lab_81_W_Y_c  = unsaturated_chrom_Lab(:, 55:57);

Lab_81_W_G_c(all(Lab_81_W_G_c' == 0), :) = [];
Lab_81_W_B_c(all(Lab_81_W_B_c' == 0), :) = [];
Lab_81_W_Pp_c(all(Lab_81_W_Pp_c' == 0), :) = [];
Lab_81_W_Pk_c(all(Lab_81_W_Pk_c' == 0), :) = [];
Lab_81_W_O_c(all(Lab_81_W_O_c' == 0), :) = [];
Lab_81_W_Y_c(all(Lab_81_W_Y_c' == 0), :) = [];

if ~XYZ2lsYChoise
  lsY_36_W_G_c  = Lab_36_W_G_c;
  lsY_36_W_B_c  = Lab_36_W_B_c;
  lsY_36_W_Pp_c = Lab_36_W_Pp_c;
  lsY_36_W_Pk_c = Lab_36_W_Pk_c;
  lsY_36_W_R_c  = Lab_36_W_R_c;
  lsY_36_W_Br_c = Lab_36_W_Br_c;
  
  lsY_58_W_G_c  = Lab_58_W_G_c;
  lsY_58_W_B_c  = Lab_58_W_B_c;
  lsY_58_W_Pp_c = Lab_58_W_Pp_c;
  lsY_58_W_Pk_c = Lab_58_W_Pk_c;
  lsY_58_W_R_c  = Lab_58_W_R_c;
  lsY_58_W_O_c  = Lab_58_W_O_c;
  lsY_58_W_Y_c  = Lab_58_W_Y_c;
  
  lsY_81_W_G_c  = Lab_81_W_G_c;
  lsY_81_W_B_c  = Lab_81_W_B_c;
  lsY_81_W_Pp_c = Lab_81_W_Pp_c;
  lsY_81_W_Pk_c = Lab_81_W_Pk_c;
  lsY_81_W_O_c  = Lab_81_W_O_c;
  lsY_81_W_Y_c  = Lab_81_W_Y_c;
else
  lsY_36_W_G_c  = XYZ2lsY(Lab2XYZ(Lab_36_W_G_c,  WhiteReference), XYZ2lsYChoise);
  lsY_36_W_B_c  = XYZ2lsY(Lab2XYZ(Lab_36_W_B_c,  WhiteReference), XYZ2lsYChoise);
  lsY_36_W_Pp_c = XYZ2lsY(Lab2XYZ(Lab_36_W_Pp_c, WhiteReference), XYZ2lsYChoise);
  lsY_36_W_Pk_c = XYZ2lsY(Lab2XYZ(Lab_36_W_Pk_c, WhiteReference), XYZ2lsYChoise);
  lsY_36_W_R_c  = XYZ2lsY(Lab2XYZ(Lab_36_W_R_c,  WhiteReference), XYZ2lsYChoise);
  lsY_36_W_Br_c = XYZ2lsY(Lab2XYZ(Lab_36_W_Br_c, WhiteReference), XYZ2lsYChoise);
  
  lsY_58_W_G_c  = XYZ2lsY(Lab2XYZ(Lab_58_W_G_c,  WhiteReference), XYZ2lsYChoise);
  lsY_58_W_B_c  = XYZ2lsY(Lab2XYZ(Lab_58_W_B_c,  WhiteReference), XYZ2lsYChoise);
  lsY_58_W_Pp_c = XYZ2lsY(Lab2XYZ(Lab_58_W_Pp_c, WhiteReference), XYZ2lsYChoise);
  lsY_58_W_Pk_c = XYZ2lsY(Lab2XYZ(Lab_58_W_Pk_c, WhiteReference), XYZ2lsYChoise);
  lsY_58_W_R_c  = XYZ2lsY(Lab2XYZ(Lab_58_W_R_c,  WhiteReference), XYZ2lsYChoise);
  lsY_58_W_O_c  = XYZ2lsY(Lab2XYZ(Lab_58_W_O_c,  WhiteReference), XYZ2lsYChoise);
  lsY_58_W_Y_c  = XYZ2lsY(Lab2XYZ(Lab_58_W_Y_c,  WhiteReference), XYZ2lsYChoise);
  
  lsY_81_W_G_c  = XYZ2lsY(Lab2XYZ(Lab_81_W_G_c,  WhiteReference), XYZ2lsYChoise);
  lsY_81_W_B_c  = XYZ2lsY(Lab2XYZ(Lab_81_W_B_c,  WhiteReference), XYZ2lsYChoise);
  lsY_81_W_Pp_c = XYZ2lsY(Lab2XYZ(Lab_81_W_Pp_c, WhiteReference), XYZ2lsYChoise);
  lsY_81_W_Pk_c = XYZ2lsY(Lab2XYZ(Lab_81_W_Pk_c, WhiteReference), XYZ2lsYChoise);
  lsY_81_W_O_c  = XYZ2lsY(Lab2XYZ(Lab_81_W_O_c,  WhiteReference), XYZ2lsYChoise);
  lsY_81_W_Y_c  = XYZ2lsY(Lab2XYZ(Lab_81_W_Y_c,  WhiteReference), XYZ2lsYChoise);
end

%% unsaturated frontiers (achromatic background)

Lab_36_W_G_a  = unsaturated_achrom_Lab(:, 1:3);
Lab_36_W_B_a  = unsaturated_achrom_Lab(:, 4:6);
Lab_36_W_Pp_a = unsaturated_achrom_Lab(:, 7:9);
Lab_36_W_Pk_a = unsaturated_achrom_Lab(:, 10:12);
Lab_36_W_R_a  = unsaturated_achrom_Lab(:, 13:15);
Lab_36_W_Br_a = unsaturated_achrom_Lab(:, 16:18);

Lab_36_W_G_a(all(Lab_36_W_G_a' == 0), :) = [];
Lab_36_W_B_a(all(Lab_36_W_B_a' == 0), :) = [];
Lab_36_W_Pp_a(all(Lab_36_W_Pp_a' == 0), :) = [];
Lab_36_W_Pk_a(all(Lab_36_W_Pk_a' == 0), :) = [];
Lab_36_W_R_a(all(Lab_36_W_R_a' == 0), :) = [];
Lab_36_W_Br_a(all(Lab_36_W_Br_a' == 0), :) = [];

Lab_58_W_G_a  = unsaturated_achrom_Lab(:, 19:21);
Lab_58_W_B_a  = unsaturated_achrom_Lab(:, 22:24);
Lab_58_W_Pp_a = unsaturated_achrom_Lab(:, 25:27);
Lab_58_W_Pk_a = unsaturated_achrom_Lab(:, 28:30);
Lab_58_W_R_a  = unsaturated_achrom_Lab(:, 31:33);
Lab_58_W_O_a  = unsaturated_achrom_Lab(:, 34:36);
Lab_58_W_Y_a  = unsaturated_achrom_Lab(:, 37:39);

Lab_58_W_G_a(all(Lab_58_W_G_a' == 0), :) = [];
Lab_58_W_B_a(all(Lab_58_W_B_a' == 0), :) = [];
Lab_58_W_Pp_a(all(Lab_58_W_Pp_a' == 0), :) = [];
Lab_58_W_Pk_a(all(Lab_58_W_Pk_a' == 0), :) = [];
Lab_58_W_R_a(all(Lab_58_W_R_a' == 0), :) = [];
Lab_58_W_O_a(all(Lab_58_W_O_a' == 0), :) = [];
Lab_58_W_Y_a(all(Lab_58_W_Y_a' == 0), :) = [];

Lab_81_W_G_a  = unsaturated_achrom_Lab(:, 40:42);
Lab_81_W_B_a  = unsaturated_achrom_Lab(:, 43:45);
Lab_81_W_Pp_a = unsaturated_achrom_Lab(:, 46:48);
Lab_81_W_Pk_a = unsaturated_achrom_Lab(:, 49:51);
Lab_81_W_O_a  = unsaturated_achrom_Lab(:, 52:54);
Lab_81_W_Y_a  = unsaturated_achrom_Lab(:, 55:57);

Lab_81_W_G_a(all(Lab_81_W_G_a' == 0), :) = [];
Lab_81_W_B_a(all(Lab_81_W_B_a' == 0), :) = [];
Lab_81_W_Pp_a(all(Lab_81_W_Pp_a' == 0), :) = [];
Lab_81_W_Pk_a(all(Lab_81_W_Pk_a' == 0), :) = [];
Lab_81_W_O_a(all(Lab_81_W_O_a' == 0), :) = [];
Lab_81_W_Y_a(all(Lab_81_W_Y_a' == 0), :) = [];

if ~XYZ2lsYChoise
  lsY_36_W_G_a  = Lab_36_W_G_a;
  lsY_36_W_B_a  = Lab_36_W_B_a;
  lsY_36_W_Pp_a = Lab_36_W_Pp_a;
  lsY_36_W_Pk_a = Lab_36_W_Pk_a;
  lsY_36_W_R_a  = Lab_36_W_R_a;
  lsY_36_W_Br_a = Lab_36_W_Br_a;
  
  lsY_58_W_G_a  = Lab_58_W_G_a;
  lsY_58_W_B_a  = Lab_58_W_B_a;
  lsY_58_W_Pp_a = Lab_58_W_Pp_a;
  lsY_58_W_Pk_a = Lab_58_W_Pk_a;
  lsY_58_W_R_a  = Lab_58_W_R_a;
  lsY_58_W_O_a  = Lab_58_W_O_a;
  lsY_58_W_Y_a  = Lab_58_W_Y_a;
  
  lsY_81_W_G_a  = Lab_81_W_G_a;
  lsY_81_W_B_a  = Lab_81_W_B_a;
  lsY_81_W_Pp_a = Lab_81_W_Pp_a;
  lsY_81_W_Pk_a = Lab_81_W_Pk_a;
  lsY_81_W_O_a  = Lab_81_W_O_a;
  lsY_81_W_Y_a  = Lab_81_W_Y_a;
else
  lsY_36_W_G_a  = XYZ2lsY(Lab2XYZ(Lab_36_W_G_a,  WhiteReference), XYZ2lsYChoise);
  lsY_36_W_B_a  = XYZ2lsY(Lab2XYZ(Lab_36_W_B_a,  WhiteReference), XYZ2lsYChoise);
  lsY_36_W_Pp_a = XYZ2lsY(Lab2XYZ(Lab_36_W_Pp_a, WhiteReference), XYZ2lsYChoise);
  lsY_36_W_Pk_a = XYZ2lsY(Lab2XYZ(Lab_36_W_Pk_a, WhiteReference), XYZ2lsYChoise);
  lsY_36_W_R_a  = XYZ2lsY(Lab2XYZ(Lab_36_W_R_a,  WhiteReference), XYZ2lsYChoise);
  lsY_36_W_Br_a = XYZ2lsY(Lab2XYZ(Lab_36_W_Br_a, WhiteReference), XYZ2lsYChoise);
  
  lsY_58_W_G_a  = XYZ2lsY(Lab2XYZ(Lab_58_W_G_a,  WhiteReference), XYZ2lsYChoise);
  lsY_58_W_B_a  = XYZ2lsY(Lab2XYZ(Lab_58_W_B_a,  WhiteReference), XYZ2lsYChoise);
  lsY_58_W_Pp_a = XYZ2lsY(Lab2XYZ(Lab_58_W_Pp_a, WhiteReference), XYZ2lsYChoise);
  lsY_58_W_Pk_a = XYZ2lsY(Lab2XYZ(Lab_58_W_Pk_a, WhiteReference), XYZ2lsYChoise);
  lsY_58_W_R_a  = XYZ2lsY(Lab2XYZ(Lab_58_W_R_a,  WhiteReference), XYZ2lsYChoise);
  lsY_58_W_O_a  = XYZ2lsY(Lab2XYZ(Lab_58_W_O_a,  WhiteReference), XYZ2lsYChoise);
  lsY_58_W_Y_a  = XYZ2lsY(Lab2XYZ(Lab_58_W_Y_a,  WhiteReference), XYZ2lsYChoise);
  
  lsY_81_W_G_a  = XYZ2lsY(Lab2XYZ(Lab_81_W_G_a,  WhiteReference), XYZ2lsYChoise);
  lsY_81_W_B_a  = XYZ2lsY(Lab2XYZ(Lab_81_W_B_a,  WhiteReference), XYZ2lsYChoise);
  lsY_81_W_Pp_a = XYZ2lsY(Lab2XYZ(Lab_81_W_Pp_a, WhiteReference), XYZ2lsYChoise);
  lsY_81_W_Pk_a = XYZ2lsY(Lab2XYZ(Lab_81_W_Pk_a, WhiteReference), XYZ2lsYChoise);
  lsY_81_W_O_a  = XYZ2lsY(Lab2XYZ(Lab_81_W_O_a,  WhiteReference), XYZ2lsYChoise);
  lsY_81_W_Y_a  = XYZ2lsY(Lab2XYZ(Lab_81_W_Y_a,  WhiteReference), XYZ2lsYChoise);
end

%% all backgrounds combined

if BackgroundType == 0
  lsY_36_G_B   = [lsY_36_G_B_c;   lsY_36_G_B_a];
  lsY_36_B_Pp  = [lsY_36_B_Pp_c;  lsY_36_B_Pp_a];
  lsY_36_Pp_Pk = [lsY_36_Pp_Pk_c; lsY_36_Pp_Pk_a];
  lsY_36_Pk_R  = [lsY_36_Pk_R_c;  lsY_36_Pk_R_a];
  lsY_36_R_Br  = [lsY_36_R_Br_c;  lsY_36_R_Br_a];
  lsY_36_Br_G  = [lsY_36_Br_G_c;  lsY_36_Br_G_a];
  
  lsY_58_G_B   = [lsY_58_G_B_c;   lsY_58_G_B_a];
  lsY_58_B_Pp  = [lsY_58_B_Pp_c;  lsY_58_B_Pp_a];
  lsY_58_Pp_Pk = [lsY_58_Pp_Pk_c; lsY_58_Pp_Pk_a];
  lsY_58_Pk_R  = [lsY_58_Pk_R_c;  lsY_58_Pk_R_a];
  lsY_58_R_O   = [lsY_58_R_O_c;   lsY_58_R_O_a];
  lsY_58_O_Y   = [lsY_58_O_Y_c;   lsY_58_O_Y_a];
  lsY_58_Y_G   = [lsY_58_Y_G_c;   lsY_58_Y_G_a];
  
  lsY_81_G_B   = [lsY_81_G_B_c;   lsY_81_G_B_a];
  lsY_81_B_Pp  = [lsY_81_B_Pp_c;  lsY_81_B_Pp_a];
  lsY_81_Pp_Pk = [lsY_81_Pp_Pk_c; lsY_81_Pp_Pk_a];
  lsY_81_Pk_O  = [lsY_81_Pk_O_c;  lsY_81_Pk_O_a];
  lsY_81_O_Y   = [lsY_81_O_Y_c;   lsY_81_O_Y_a];
  lsY_81_Y_G   = [lsY_81_Y_G_c;   lsY_81_Y_G_a];
elseif BackgroundType == 1 % chromatic
  lsY_36_G_B   = lsY_36_G_B_c;
  lsY_36_B_Pp  = lsY_36_B_Pp_c;
  lsY_36_Pp_Pk = lsY_36_Pp_Pk_c;
  lsY_36_Pk_R  = lsY_36_Pk_R_c;
  lsY_36_R_Br  = lsY_36_R_Br_c;
  lsY_36_Br_G  = lsY_36_Br_G_c;
  
  lsY_58_G_B   = lsY_58_G_B_c;
  lsY_58_B_Pp  = lsY_58_B_Pp_c;
  lsY_58_Pp_Pk = lsY_58_Pp_Pk_c;
  lsY_58_Pk_R  = lsY_58_Pk_R_c;
  lsY_58_R_O   = lsY_58_R_O_c;
  lsY_58_O_Y   = lsY_58_O_Y_c;
  lsY_58_Y_G   = lsY_58_Y_G_c;
  
  lsY_81_G_B   = lsY_81_G_B_c;
  lsY_81_B_Pp  = lsY_81_B_Pp_c;
  lsY_81_Pp_Pk = lsY_81_Pp_Pk_c;
  lsY_81_Pk_O  = lsY_81_Pk_O_c;
  lsY_81_O_Y   = lsY_81_O_Y_c;
  lsY_81_Y_G   = lsY_81_Y_G_c;
elseif BackgroundType == 2 % achromatic
  lsY_36_G_B   = lsY_36_G_B_a;
  lsY_36_B_Pp  = lsY_36_B_Pp_a;
  lsY_36_Pp_Pk = lsY_36_Pp_Pk_a;
  lsY_36_Pk_R  = lsY_36_Pk_R_a;
  lsY_36_R_Br  = lsY_36_R_Br_a;
  lsY_36_Br_G  = lsY_36_Br_G_a;
  
  lsY_58_G_B   = lsY_58_G_B_a;
  lsY_58_B_Pp  = lsY_58_B_Pp_a;
  lsY_58_Pp_Pk = lsY_58_Pp_Pk_a;
  lsY_58_Pk_R  = lsY_58_Pk_R_a;
  lsY_58_R_O   = lsY_58_R_O_a;
  lsY_58_O_Y   = lsY_58_O_Y_a;
  lsY_58_Y_G   = lsY_58_Y_G_a;
  
  lsY_81_G_B   = lsY_81_G_B_a;
  lsY_81_B_Pp  = lsY_81_B_Pp_a;
  lsY_81_Pp_Pk = lsY_81_Pp_Pk_a;
  lsY_81_Pk_O  = lsY_81_Pk_O_a;
  lsY_81_O_Y   = lsY_81_O_Y_a;
  lsY_81_Y_G   = lsY_81_Y_G_a;
end
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'green', 'blue', lsY_36_G_B, lsY_58_G_B, lsY_81_G_B);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'blue', 'purple', lsY_36_B_Pp, lsY_58_B_Pp, lsY_81_B_Pp);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'purple', 'pink', lsY_36_Pp_Pk, lsY_58_Pp_Pk, lsY_81_Pp_Pk);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'pink', 'red', lsY_36_Pk_R, lsY_58_Pk_R, []);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'red', 'brown', lsY_36_R_Br, [], []);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'brown', 'green', lsY_36_Br_G, [], []);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'red', 'orange', [], lsY_58_R_O, []);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'orange', 'yellow', [], lsY_58_O_Y, lsY_81_O_Y);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'yellow', 'green', [], lsY_58_Y_G, lsY_81_Y_G);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'pink', 'orange', [], [], lsY_81_Pk_O);

lsY_36_W_G   = [lsY_36_W_G_c;   lsY_36_W_G_a];
lsY_36_W_B   = [lsY_36_W_B_c;   lsY_36_W_B_a];
lsY_36_W_Pp  = [lsY_36_W_Pp_c;  lsY_36_W_Pp_a];
lsY_36_W_Pk  = [lsY_36_W_Pk_c;  lsY_36_W_Pk_a];
lsY_36_W_R   = [lsY_36_W_R_c;   lsY_36_W_R_a];
lsY_36_W_Br  = [lsY_36_W_Br_c;  lsY_36_W_Br_a];

lsY_58_W_G   = [lsY_58_W_G_c;   lsY_58_W_G_a];
lsY_58_W_B   = [lsY_58_W_B_c;   lsY_58_W_B_a];
lsY_58_W_Pp  = [lsY_58_W_Pp_c;  lsY_58_W_Pp_a];
lsY_58_W_Pk  = [lsY_58_W_Pk_c;  lsY_58_W_Pk_a];
lsY_58_W_R   = [lsY_58_W_R_c;   lsY_58_W_R_a];
lsY_58_W_O   = [lsY_58_W_O_c;   lsY_58_W_O_a];
lsY_58_W_Y   = [lsY_58_W_Y_c;   lsY_58_W_Y_a];

lsY_81_W_G   = [lsY_81_W_G_c;   lsY_81_W_G_a];
lsY_81_W_B   = [lsY_81_W_B_c;   lsY_81_W_B_a];
lsY_81_W_Pp  = [lsY_81_W_Pp_c;  lsY_81_W_Pp_a];
lsY_81_W_Pk  = [lsY_81_W_Pk_c;  lsY_81_W_Pk_a];
lsY_81_W_O   = [lsY_81_W_O_c;   lsY_81_W_O_a];
lsY_81_W_Y   = [lsY_81_W_Y_c;   lsY_81_W_Y_a];

[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'grey', 'green', lsY_36_W_G, lsY_58_W_G, lsY_81_W_G);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'grey', 'blue', lsY_36_W_B, lsY_58_W_B, lsY_81_W_B);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'grey', 'purple', lsY_36_W_Pp, lsY_58_W_Pp, lsY_81_W_Pp);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'grey', 'pink', lsY_36_W_Pk, lsY_58_W_Pk, lsY_81_W_Pk);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'grey', 'red', lsY_36_W_R, lsY_58_W_R, []);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'grey', 'brown', lsY_36_W_Br, [], []);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'grey', 'orange', [], lsY_58_W_O, lsY_81_W_O);
[ColourFrontiers, borders] = AddColourBorders365881(borders, ColourFrontiers, 'grey', 'yellow', [], lsY_58_W_Y, lsY_81_W_Y);

%% new experiments

ScriptPath = mfilename('fullpath');
DirPath = strrep(ScriptPath, 'matlab/src/algorithms/colourcategorisation/fitting/OrganiseExperimentFrontiers', 'matlab/data/mats/results/experiments/colourfrontiers/real/');

MatFiles = dir([DirPath, '*.mat']);

for i = 1:length(MatFiles)
  CurrentMatPath = [DirPath, MatFiles(i).name];
  [ColourFrontiers, borders] = ReadExperimentResults(CurrentMatPath, ColourFrontiers, borders, XYZ2lsYChoise, BackgroundType);
end

if plotme
  figure('NumberTitle', 'Off', 'Name', 'Colour Frontiers');
  hold on;
  PlotColourBorders(borders);
  xlabel('l');
  ylabel('s');
  zlabel('Y');
  grid on;
end

end

function [lsYFrontiers, borders] = AddColourBorders365881(borders, lsYFrontiers, ColourA, ColourB, lum36, lum58, lum81)

border = ColourBorder(lsYFrontiers.(ColourA), lsYFrontiers.(ColourB), lum36, 36);
border = border.AddPoints(lum58, 58);
border = border.AddPoints(lum81, 81);
lsYFrontiers.(ColourA) = lsYFrontiers.(ColourA).AddBorder(border);
lsYFrontiers.(ColourB) = lsYFrontiers.(ColourB).AddBorder(border);
borders{end + 1} = border;

end

function [] = PlotColourBorders(borders)

for i = 1:length(borders)
  borderi = borders{i};
  borderi.PlotBorders();
end

end
