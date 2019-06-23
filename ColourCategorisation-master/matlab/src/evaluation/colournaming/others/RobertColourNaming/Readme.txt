COLOR NAMING CODE

There are two functions:


'SampleColorNaming' applies the TSE model to a single sRGB value.
It returns the membership values to the 11 basic color categories
and the color term corresponding to the highest membership value.

[res,CD]=SampleColorNaming(s,parFileName1,parFileName2,parFileName3)

% SampleColorNaming: Given a sRGB sample, returns the color name assigned to 
%                    the sample by the color naming model (in 'res') and the 
%                    11 memberships to the 11 basic colors (in 'CD')
% s                - Sample in sRGB format [R G B]
% parFileName1     - File name for parameters of the model (chromatic colors)
% parFileName2     - File name for parameters of the model (achromatic colors)
% parFileName3     - File name for parameters of the model (lightness levels)



'ImColorNamingTSELab' applies the TSE model to a sRGB image. 
It returns an image with each pixel labelled with the representative RGB color 
corresponding to the category with the highest membership value at the pixel, 
an image with an index correponding to the category with the highst membership
value at the pixel, and a matrix with the membership values to the 11 basic color 
categories for every pixel in the image.

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



DemoColornaming.m contains a demo of the use of these two functions.


