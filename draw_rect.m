gg = imread('./data/diving/diving-template.jpg');
gg = rgb2gray(gg);
position = find_rect(gg);
figure;
imshow(gg);hold on; 
rectangle('Position',position,'LineWidth',2,'EdgeColor','r');

kk = imread('./data/diving/diving-01.jpg');
kk = rgb2gray(kk);
position = find_rect(kk);
figure;
imshow(kk);hold on; 
rectangle('Position',position,'LineWidth',2,'EdgeColor','r');