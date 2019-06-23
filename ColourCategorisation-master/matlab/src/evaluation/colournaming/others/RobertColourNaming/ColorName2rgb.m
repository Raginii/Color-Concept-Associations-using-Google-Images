% ColorName2rgb: Given a matrix with a set of color names, returns the RGB values representing each color name
function RGB=ColorName2rgb(colorNames)

n=size(colorNames,1);
RGB=zeros(n,3);
RGB=repmat(strcmp(colorNames,'Red'),1,3).*repmat([1.0 0.0 0.0],n,1) + repmat(strcmp(colorNames,'Orange'),1,3).*repmat([1.0 0.6 0.0],n,1)+ repmat(strcmp(colorNames,'Brown'),1,3).*repmat([0.4 0.2 0.0],n,1)+ repmat(strcmp(colorNames,'Yellow'),1,3).*repmat([1.0 1.0 0.0],n,1)+ repmat(strcmp(colorNames,'Green'),1,3).*repmat([0.0 1.0 0.0],n,1)+ repmat(strcmp(colorNames,'Blue'),1,3).*repmat([0.0 0.0 1.0],n,1)+ repmat(strcmp(colorNames,'Purple'),1,3).*repmat([0.7 0.0 0.7],n,1)+ repmat(strcmp(colorNames,'Pink'),1,3).*repmat([0.8 0.6 0.7],n,1)+ repmat(strcmp(colorNames,'Black'),1,3).*repmat([0.0 0.0 0.0],n,1)+ repmat(strcmp(colorNames,'Grey'),1,3).*repmat([0.5 0.5 0.5],n,1)+ repmat(strcmp(colorNames,'White'),1,3).*repmat([1.0 1.0 1.0],n,1);

