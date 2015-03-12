% 输出目录里的图片
processed_dir = './dataset/archery';
imgs = dir(processed_dir);
img_num = length(imgs);

for i = 3:img_num
    disp([imgs(i).name, ' ']);
end