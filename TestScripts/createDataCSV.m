%%
% % % Creates the labels for the concepts for every color using human
% ratings
load ColorObjAssocLoad.mat

r = size(AssocLoad,2);  % Number of concepts
c = size(AssocLoad,1);  % Number of colors

data = zeros(r,c);
for i = 1:r
    % Mean of all the 49 ratings scaled
    data(i,:) = (mean(AssocLoad(:,i,:),3) + 200)/400.0 ;
end
csvwrite('data_clean_test.csv',data);
%%
% % % Creates RGB and LAB values for the defined colors
filename = "BCP37coordinates.xlsx";
colors_xyY = xlsread(filename);

% BCP illuminant = [0.312, 0.318, 116]
colors = colorconvert( colors_xyY, 'xyY', [0.312, 0.318, 116], 'xyY' )
Lab = [colors.L colors.a colors.b];
%scatter3(Lab(:,2),Lab(:,3),Lab(:,1),50,cat,'filled','MarkerEdgeColor',[0 0 0]);
RGB = lab2rgb(Lab)

% csvwrite('Lab_test.csv',Lab);
% csvwrite('RGB_test.csv',RGB);
%% 
% Adjusted the colors to include them in the RGB space gamut
% using adjustBCPcolors.m

RGB = csvread('RGB_test.csv')
% % % Gets category color for every defined color
cd ../ColourCategorisation-master
cat = zeros(size(RGB,1),1)
for i = 1:size(RGB,1)
    coord = RGB(i,:)
    val = (rgb2belonging(coord));
    belonging2naming(val)
    cat(i,1) = belonging2naming(val);
end
% bel = lab2belonging(Lab);
% cat = belonging2naming(bel);
cd ../TestScripts
csvwrite('Category_test.csv',cat);
%% rgbColor
categ = csvread('Category_test.csv');
LabT = csvread('Lab_test.csv');
rgbT = csvread('RGB_test.csv');
cd ../ColourCategorisation-master
rgbCol = double(ColourLabelImage(categ))/255
cd ../TestScripts
rgbColor = reshape(rgbCol,[size(RGB,1),3])
% scatter3(LabT(:,2),LabT(:,3),LabT(:,1),50,rgbColor,'filled','MarkerEdgeColor',[0 0 0])
scatter3(LabT(:,2),LabT(:,3),LabT(:,1),60,rgbT,'filled','Marker','o','MarkerEdgeColor',[0 0 0])
refCol = ["SR" "LR" "MR" "DR" "SO" "LO" "MO" "DO" "SY" "LY" "MY" "DY" "SH" "LH" "MH" "DH" "SG" "LG" "MG" "DG" "SC" "LC" "MC" "DC" "SB" "LB" "MB" "DB" "SP" "LP" "MP" "DP" "BK" "A1" "A2" "A3" "WH"]

for i = 1: length(categ)
    text(LabT(i,2)+2,LabT(i,3)+2,LabT(i,1)+2,num2str(i)+refCol(i));
end
%%
c = ["Green", "Blue", "Purple", "Pink", "Red", "Orange", "Yellow", "Brown", "Grey", "White", "Black"]
for i = 1:37
    fprintf("\n %s",c(categ(i)))
end