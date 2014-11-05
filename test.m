imgs = dir('./data/archery/');
img_num = length(imgs);
data = zeros(84,1584);
template = imread('./data/archery/archery-template.jpg');
tem = rgb2gray(template);
tem = denoise(tem);
[tem_w, tem_h] = findTemplateScale(tem);

for i = 3:img_num
    img = imread(strcat('./data/archery/', imgs(i).name));
    disp(['processing the number ',num2str(i-2),' pic: ', imgs(i).name]);
    img_gray = rgb2gray(img);
    img_gray = denoise(img_gray);
    
    img_gray = resizeImage(img_gray, tem_w, tem_h);
    tmp = hierHog(img_gray);
    data(i-2,:) = tmp;
end
disp('done!');
save('data', 'data');

ranking = zeros(1,83);
for i = 1:img_num-3
    cost = dist(data(84,:),data(i,:));
    ranking(i) = cost;
end

[B,I] = sort(ranking);
figure;
for i =54:83
    img = imread(strcat('./data/archery/', imgs(I(i)+2).name));
%     position_vector = [0.1*(i-1), ];
    subplot(5,6,i-53);
    imshow(img);
end

