gg = imread('./data/boxing_1/boxing-template.jpg');
gg = rgb2gray(gg);
position = find_rect(gg);
figure;
imshow(gg);hold on; 
rectangle('Position',position,'LineWidth',2,'EdgeColor','r');

kk = imread('./data/boxing_1/boxing-02.jpg');
kk = rgb2gray(kk);
position = find_rect(kk);
figure;
imshow(kk);hold on; 
rectangle('Position',position,'LineWidth',2,'EdgeColor','r');