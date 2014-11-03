template = imread('./data/archery/archery-template.jpg');
tem = rgb2gray(template);
tem = denoise(tem);
[tem_w, tem_h] = findTemplateScale(tem);
tem = resizeImage(tem, tem_w, tem_h);