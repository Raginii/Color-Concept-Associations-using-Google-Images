function imgCat = getCategories(imgFile,sz)
    imgRGB = imread(imgFile);
    imgRGB = imresize(imgRGB,[sz,sz]);
    ct = zeros(11,1);
    cd ColourCategorisation-master
    temp = rgb2belonging(imgRGB);
    imgCat = belonging2naming(temp);

%     for i =1:size(imgCat,1)
%         for j = 1:size(imgCat,2)
%             cat = imgCat(i,j);
%             ct(cat) = ct(cat)+1;
%         end
%     end
%     imgCat = ct;
%     
    cd ../
end