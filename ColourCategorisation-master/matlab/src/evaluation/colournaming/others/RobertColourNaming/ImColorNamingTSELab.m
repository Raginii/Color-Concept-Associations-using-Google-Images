% [imaRes,imaIndex,CD]=ImColorNamingTSELab(ima,parFileName1,parFileName2,parFileName3)
% 
% Given an image in sRGB format, applies the color naming model and returns:
% imaRes - image with each pixel painted the representative RGB colour of  
%          the maximum membership value given by the color naming model
% imaIndex - image labelled with an integer representing the name with 
%            highest membership (1=Red,2=Orange,3=Brown,4=Yellow,5=Green,
%            6=Blue,7=Purple,8=Pink,9=Black,10=Grey,11=White)
% CD- a matrix with the 11 memberships for each pixel. The membership 
%     values in the third dimension of CD are ordered: Red,Orange,Brown,
%     Yellow,Green,Blue,Purple,Pink,Black,Grey,White
%
% Input arguments:
% ima          - Input image
% parFileName1 - File name for parameters of the model (chromatic colors)
% parFileName2 - File name for parameters of the model (achromatic colors)
% parFileName3 - File name for parameters of the model (lightness levels)

function [imaRes,imaIndex,CD]=ImColorNamingTSELab(ima,parFileName1,parFileName2,parFileName3)

% Constants
colors={'Red' 'Orange' 'Brown' 'Yellow' 'Green' 'Blue' 'Purple' 'Pink' 'Black' 'Grey' 'White'};
numColors=11;                           % Number of colors
numAchromatics=3;                       % Number of achromatic colors
numChromatics=numColors-numAchromatics; % Number of chromatic colors

% Load Files with color-naming model parameters
load(parFileName1);                     % Contains structure 'parameters'
load(parFileName2);                     % Contains structure 'thrL'
load(parFileName3);                     % Contains structure 'paramsAchro'

%Initializations
numLevels=size(thrL,2)-1;               % Number of Lightness levels in the model
[nr,nc,nch]=size(ima);                  % Image dimensions: rows, columns, and channels
np=nr*nc;                               % Number of pixels
CD=zeros(np,numColors);                 % Color descriptor to store results

% Image conversion: sRGB to CIELab
cform=makecform('srgb2lab','AdaptedWhitePoint', whitepoint('D65')); 
imaLab=applycform(double(ima)/255,cform);
L=reshape(imaLab(:,:,1),np,1);
a=reshape(imaLab(:,:,2),np,1);
b=reshape(imaLab(:,:,3),np,1);

% Assignment of all pixels to their corresponding level
m=(L==0);                               % Pixels with L=0 assigned to level 1
k=1;
while (k<=numLevels)
    m=m+((thrL(k)<L).*(L<=thrL(k+1))).*k;
    k=k+1;
end

% Computing membership values to chromatic categories
for k=1:numChromatics
    tx=reshape(parameters(k,1,m),np,1);
    ty=reshape(parameters(k,2,m),np,1);
    alfa_x=reshape(parameters(k,3,m),np,1);
    alfa_y=reshape(parameters(k,4,m),np,1);
    beta_x=reshape(parameters(k,5,m),np,1);
    beta_y=reshape(parameters(k,6,m),np,1);
    beta_e=reshape(parameters(k,7,m),np,1);
    ex=reshape(parameters(k,8,m),np,1);
    ey=reshape(parameters(k,9,m),np,1);
    angle_e=reshape(parameters(k,10,m),np,1);
    CD(:,k)=(beta_e~=0.0).*TripleSigmoid_E([a b],tx,ty,alfa_x,alfa_y,beta_x,beta_y,beta_e,ex,ey,angle_e);
end

% Computing membership values to achromatic categories
valueAchro=max(1-sum(CD,2),zeros(np,1));
CD(:,numChromatics+1)=valueAchro.*Sigmoid(L,paramsAchro(1,1),paramsAchro(1,2));
CD(:,numChromatics+2)=valueAchro.*Sigmoid(L,paramsAchro(2,1),paramsAchro(2,2)).*Sigmoid(L,paramsAchro(3,1),paramsAchro(3,2));
CD(:,numChromatics+3)=valueAchro.*Sigmoid(L,paramsAchro(4,1),paramsAchro(4,2));


% Output image with each pixel labelled with the colour of maximum membership value
[M,index]=max(CD,[],2);
imaRes=reshape(reshape(ColorName2rgb(colors(index)'),np,1,3),nr,nc,3);

% Output image with each pixel labelled with the colour of maximum membership value
imaIndex=reshape(index,nr,nc);

% Color descriptor with color memberships to all the categories (one color in each plane)
CD=reshape(CD,nr,nc,numColors);

