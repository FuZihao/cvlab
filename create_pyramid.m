% i0 = imread('./data/triathlon/triathlon-template.jpg');
i00 = imread('./data/triathlon/triathlon-template.jpg');
i01 = impyramid(i00, 'reduce');
i02 = impyramid(i01, 'reduce');
i03 = impyramid(i02, 'reduce');

% imshow(i00);
% figure, imshow(i01);
% figure, imshow(i02);
% figure, imshow(i03);

i10 = imread('./data/triathlon/triathlon-01.jpg');
i11 = impyramid(i10, 'reduce');
i12 = impyramid(i11, 'reduce');
i13 = impyramid(i12, 'reduce');

% imshow(i10);
% figure, imshow(i11);
% figure, imshow(i12);
% figure, imshow(i13);

i20 = imread('./data/boxing/boxing-template.jpg');
i21 = impyramid(i20, 'reduce');
i22 = impyramid(i21, 'reduce');
i23 = impyramid(i22, 'reduce');

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