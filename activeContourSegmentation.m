function [segImg,segImgCat] = activeContourSegmentation(imgFile,sz)
    Init = imread(imgFile);
    Irgb = imresize(Init,[sz,sz]);
    % get category colors of this image beforehand
    cd ColourCategorisation-master
    temp = rgb2belonging(Irgb);
    categories = belonging2naming(temp);
    cd ../
    
    I = rgb2gray(Irgb);
    mask = ones(size(I));
    iter = 500;
    bw = activecontour(I,mask,iter);
   
    [r,c] = find(bw);
    segImg = zeros(size(r,1),1,3);
    segImgCat = zeros(size(r,1),1);
    for i = 1:size(r)
        segImg(i,1,:)= Irgb(r(i),c(i),:);
        segImgCat(i,1) = categories(r(i),c(i));
    end
    %imshow(bw);
    % don't panic: you are converting to LAB in python script 
end