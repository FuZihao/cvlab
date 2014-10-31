imgs = dir('./data/archery/');
img_num = length(imgs);
data = zeros(84,1584);

for i = 3:img_num
    img = imread(strcat('./data/archery/', imgs(i).name));
    disp(['processing the number ',num2str(i-2),' pic: ', imgs(i).name]);
    img_gray = rgb2gray(img);
    img_gray = denoise(img_gray);
    img_gray = resize_image(img_gray);
    tmp = hier_hog(img_gray);
    data(i-2,:) = tmp;
end
disp('done!');
save('data', 'data');

ranking = zeros(1,83);
for i = 1:img_num-3
    cost = dist(data(11,:),data(i,:));
    ranking(i) = cost;
end

[B,I] = sort(ranking);
% figure;
% for i =1:10
%     img = imread(strcat('./data/boxing_1/', imgs(I(i)+2).name));
%     subplot(2,5,i);
%     imshow(img);
%     axis image;
% end

% 
% t = imread('./data/boxing_1/diving-template.jpg');
% t = rgb2gray(t);
% t_res = resize_image(t);
% hog = hier_hog(t_res);


% imshow(t_res);
% 
% t_res3 = impyramid(t_res, 'reduce');
% t_res2 = impyramid(t_res3, 'reduce');
% t_res1 = impyramid(t_res2, 'reduce');
% 
% imshow(t_res1);
% [y1,x1] = size(t_res1);
% [features,vil1]= extractHOGFeatures(t_res1,'CellSize',[y1 floor(x1/2)],...
%                                                 'BlockSize',[1 2],...
%                                                 'BlockOverlap',[0 0],...
%                                                 'NumBins',18,...
%                                                 'UseSignedOrientation',true);
% plot(vil1);