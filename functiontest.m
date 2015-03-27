% 此脚本用来测试函数功能

% x1 = -17:1:3;
% y1 = 1./((x1+3).^2+1) + 1./((x1+9).^2+4)+5;
% x2 = -17:0.02:3;
% y2 = 1./((x2+3).^2+1) + 1./((x2+9).^2+4)+5;
% 
% subplot(2,2,1);
% plot(x1, y1, 'rp');
% axis([-17 3 5 6.5]);
% title('figure1');
% grid on;
% 
% subplot(2,2,2);
% plot(x2, y2, 'rp');
% axis([-17 3 5 6.5]);
% title('figure2');
% grid on;
% 
% subplot(2,2,3);
% plot(x1, y1, x1, y1, 'rp');
% axis([-17 3 5 6.5]);
% title('figure3');
% grid on;
% 
% subplot(2,2,4);
% plot(x2, y2, 'LineWidth', 2);
% axis([-17 3 5 6.5]);
% title('figure4');
% grid on;

% x1 = 1;
% x2 = 10;
% y1 = 1;
% y2 = 10; 
% 
% xx1 = x1:1:x2;
% yy1 = y1:1:y2;
% 
% rectangle_x = [xx1;xx1;repmat(x1,1,10);repmat(x2,1,10)];
% rectangle_y = [repmat(y1,1,10);repmat(y2,1,10);yy1;yy1];
% figure(1);
%  hold on;
% imshow('./data/archery/archery-01.jpg');
% % hold on;
% % plot(rectangle_x, rectangle_y, 'b.');
% % axis([0 11 0 11]);
% xi=[0.5 0.5 0.55 0.55 0.5];
% yi=[100 150 150 100 100];
% plot(xi,yi,'g')

% img =  imread('./data/archery/archery-01.jpg');
% features = extractHOGFeatures(img);
% [featureVector, hogVisualization] = extractHOGFeatures(img);
% figure;
% imshow(img); hold on;
% plot(hogVisualization);

% img1 = imread('./dataset/golf/golf-07.jpg');
% % img2 = imread('./data/archery/archery-02.jpg');
% img1 = rgb2gray(img1);
% % img1 = denoise(img1);
% % img1 = mat2gray(img1);
% % figure;
% % img1 = im2gray(img1);
% imshow(img1);
% impixelinfo;
% [angle, magnitude] = im2gradient(img1);
% figure,imshow(uint8(angle));
% impixelinfo;
% figure,imshow(uint8(magnitude));
% impixelinfo;

% hold on;
% imshow(img2);
% rectangle('Position',[100,300,70,50],'Curvature',[0,0],'LineWidth',2,'LineStyle','--','EdgeColor','r');
% hold off;

% I2 = imread('./data/boxing/boxing-01.jpg');
% corners   = detectFASTFeatures(rgb2gray(I2));
% strongest = selectStrongest(corners,3);
% [hog2, validPoints, ptVis] = extractHOGFeatures(I2,corners);
% figure;
% imshow(I2); hold on;
% plot(ptVis,'Color','green');

% im = repmat([1,0;1,1], 3, 3);
% feature = myHOG(im, [2,2], [2,2], [0,0], 18, 1);

% iter1 = 1;
% cost1 = 1;
% iter2 = 2;
% cost2 = 2;
% plot(iter1, cost1, '-b.');
% hold on;
% plot(iter2, cost2, '-b.');
% hold off;

% iter = [];
% iter = [iter, 1];
% cost = [];
% cost = [cost, 1];
% plot(iter, cost, '-b.');
% hold on;
% iter = [iter, 2];
% cost = [cost, 2];
% plot(iter, cost, '-b.');
% hold off;

iter = [];
cost = [];
for i = 1:20
    iter = [iter, i];
    cost = [cost, i];
    plot(iter, cost, '-b.');
    hold on;
end
hold off;