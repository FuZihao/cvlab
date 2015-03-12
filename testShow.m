% 测试一些显示功能

template = imread('./data/archery/archery-03.jpg');
tem = rgb2gray(template);
tem = denoise(tem);
[tem_w, tem_h] = findTemplateScale(tem);
tem = resizeImage(tem, tem_w, tem_h);
drawRect(tem);
% 
% tem = im2bw(tem,0.9);
% se = strel('disk',10);
% erodedim = imdilate(tem,se);
% imshow(tem);
% figure;imshow(erodedim);

% iml1 = imread('./data/archery/archery-03.jpg');
% im11 = rgb2gray(im11);
% im11 = denoise(im11);
% im11 = resizeImage(im11, tem_w, tem_h);
% drawRect(im11);

% figure;
% position_vector1 = [0, 0.7, 0.3, 0.3];
% subplot('Position', position_vector1);
% imshow(template);
% 
% position_vector2 = [0.3, 0.7, 0.4, 0.4];
% subplot('Position', position_vector2);
% imshow(iml1);
% figure;
% subplot(1,2,1);
% imshow(template);
% subplot(1,2,2);
% imshow(iml1);