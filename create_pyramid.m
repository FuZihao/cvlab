% i0 = imread('./data/triathlon/triathlon-template.jpg');
% i00 = imread('./data/triathlon/triathlon-template.jpg');
% i01 = impyramid(i00, 'reduce');
% i02 = impyramid(i01, 'reduce');
% i03 = impyramid(i02, 'reduce');

% imshow(i00);
% figure, imshow(i01);
% figure, imshow(i02);
% figure, imshow(i03);

% i10 = imread('./data/triathlon/triathlon-01.jpg');
% i11 = impyramid(i10, 'reduce');
% i12 = impyramid(i11, 'reduce');
% i13 = impyramid(i12, 'reduce');

% imshow(i10);
% figure, imshow(i11);
% figure, imshow(i12);
% figure, imshow(i13);

% i20 = imread('./data/boxing/boxing-template.jpg');
% i21 = impyramid(i20, 'reduce');
% i22 = impyramid(i21, 'reduce');
% i23 = impyramid(i22, 'reduce');

% imshow(i10);
% figure, imshow(i11);
% figure, imshow(i12);
% figure, imshow(i23);

% X = imread('./data/triathlon/triathlon-01.jpg');
% figure
% subplot(1,2,1)
% imagesc(X)
% colormap(gray)
% axis image
% title('Default CLim (= [1 81])')

% img_g1 = impyramid(img_g, 'reduce');
% img_g2 = impyramid(img_g1, 'reduce');
% img_g3 = impyramid(img_g2, 'reduce');
% imshow(img_g);
% figure, imshow(img_g1);
% figure, imshow(img_g2);
% figure, imshow(img_g3);

img_k1 = impyramid(img_k, 'reduce');
img_k2 = impyramid(img_k1, 'reduce');
img_k3 = impyramid(img_k2, 'reduce');
% imshow(img_k);
% figure, imshow(img_k1);
% figure, imshow(img_k2);
figure, imshow(img_k1); % 62 60
hold on;
% position1 = [0 0 30 62];
% rectangle('Position',position1,'LineWidth',1,'EdgeColor','r');
% position2 = [31 1 30 61];
% rectangle('Position',position2,'LineWidth',1,'EdgeColor','r');
% XX = 0:30:60;
% YY = 0:31:62;
% [XXX,YYY] = meshgrid(XX,YY);
% mesh(XXX,YYY);
[XX,YY] = size(img_k1);
inc_x = floor(XX/4);
inc_y = floor(YY/4);
for ii = 0:inc_x:XX
    for kk = 0:inc_y:YY
        position = [ii kk inc_x inc_y];
        rectangle('Position', position, 'LineWidth',1,'EdgeColor','r');
    end
end

img_g1 = impyramid(img_g, 'reduce');
img_g2 = impyramid(img_g1, 'reduce');
img_g3 = impyramid(img_g2, 'reduce');
% imshow(img_k);
% figure, imshow(img_k1);
% figure, imshow(img_k2);
figure, imshow(img_g1); % 62 60
hold on;
% position1 = [0 0 30 62];
% rectangle('Position',position1,'LineWidth',1,'EdgeColor','r');
% position2 = [31 1 30 61];
% rectangle('Position',position2,'LineWidth',1,'EdgeColor','r');
% XX = 0:30:60;
% YY = 0:31:62;
% [XXX,YYY] = meshgrid(XX,YY);
% mesh(XXX,YYY);
[XX,YY] = size(img_g1);
inc_x = floor(XX/4);
inc_y = floor(YY/4);
for ii = 0:inc_x:XX
    for kk = 0:inc_y:YY
        position = [ii kk inc_x inc_y];
        rectangle('Position', position, 'LineWidth',1,'EdgeColor','r');
    end
end