img = imread('downloads/Clouds/17. Clouds.jpg');
sz = 100
img = imresize(img,[sz,sz]);
%cd ColourCategorisation-master
img  = img(20:84,20:84,:)
temp = rgb2belonging(img);
labelImg = belonging2naming(temp);
imgNew = ColourLabelImage(labelImg);
figure(1), imshow(img);
figure(2), imshow(imgNew);

ct = zeros(11,1);
for i =1:sz
    for j = 1:sz
        cat = labelImg(i,j);
        ct(cat) = ct(cat)+1;
    end
end

%%
rgb = csvread('RGB.csv');
belong = rgb2belonging(rgb);
category = belonging2naming(belong);
csvwrite('category.csv',category)
