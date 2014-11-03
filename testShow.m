template = imread('./data/archery/archery-template.jpg');
tem = rgb2gray(template);
tem = denoise(tem);
[tem_w, tem_h] = findTemplateScale(tem);
tem = resizeImage(tem, tem_w, tem_h);
drawRect(tem);

im11 = imread('./data/archery/archery-03.jpg');
im11 = rgb2gray(im11);
im11 = denoise(im11);
im11 = resizeImage(im11, tem_w, tem_h);
drawRect(im11);