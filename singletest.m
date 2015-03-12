%     clear;
%     processed_dir = './dataset/baseball/';
%     template_name = './dataset/baseball/baseball-00.jpg'; % 每个类别下的第一张图片为模板图
%     feature_dim = 1584;
%     imgs = dir(processed_dir);
%     img_num = length(imgs);
%     data = zeros(img_num,feature_dim);
%     template = imread(template_name);
%     tem = rgb2gray(template);
%     tem = denoise(tem);
%     [tem_w, tem_h] = findTemplateScale(tem);
%     
%      i = 3+3; % 跳过 . 和 .. 文件
%         img = imread(strcat(processed_dir, imgs(i).name));
%         disp(['processing the number ',num2str(i-2),' pic: ', imgs(i).name]);
%         img_gray = rgb2gray(img);
%         img_gray = denoise(img_gray);
%         
%         img_gray = resizeImage(img_gray, tem_w, tem_h);
%         imshow(img_gray);
%         tmp = hierHog(img_gray);
%         data(i-2,:) = tmp;
%     disp('done!');

imgName = './dataset/archery/archery-07.jpg';
im = imread(imgName);
im = rgb2gray(im);
im = denoise(im);
% drawRect(im);
feature = hierHog(im);
