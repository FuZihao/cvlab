% BW1 = imread('./data/archery/archery-01.jpg');
% BW2 = bwmorph(BW1,'remove');
% figure
% imshow(BW2)

im = imread('./data/archery/archery-01.jpg');
im1 = im2bw(im,0.8);
figure;
imshow(im1);
im2 = bwmorph(im1,'thin',Inf);
figure;
imshow(im2);