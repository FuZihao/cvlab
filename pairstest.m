% 本脚本采用特定的算法，对两张图片进行对比试验

% template = imread('./data/archery/archery-template.jpg');
% tem = rgb2gray(template);
% tem = denoise(tem);
% [tem_w, tem_h] = findTemplateScale(tem);
% templateFeatures = hierHog(tem);
% 
% comparedDrawning = imread('./data/archery/archery-template.jpg');
% grayDrawning = rgb2gray(comparedDrawning);
% grayDrawning = denoise(grayDrawning);
% grayDrawning = resizeImage(grayDrawning, tem_w, tem_h);
% grayDrawningFeatures = hierHog(grayDrawning);
% 
% cost = dist(templateFeatures, grayDrawning);

% imgName = './dataset/archery/archery-07.jpg';
% im = imread(imgName);
% im = rgb2gray(im);
% % im = denoise(im);
% drawRect(im);

processDir = './rankingsvm/dataset/shooting/drawing/';
picNames = dir(processDir);
picCount = length(picNames);
% templateName = './dataset/archery/archery-00.jpg';
templateName = strcat(processDir, 'shooting-00.jpg');
template = imread(templateName);
template = rgb2gray(template);
% temROI = findRect(template);
[tem_w, tem_h] = findTemplateScale(template);
temResized = resizeImage(template, tem_w, tem_h);
[temAngle, temMag ] = im2gradient(temResized);
% drawRect(temAngle);
templateFeature = hierHog(temResized);

% select a random picture for comparing with the template picture
% while true
%     randNum = randi([1, picCount-2]);
%     randPic = picNames(randNum).name;
%     if ~isdir(randPic)
%         img = imread(strcat(processDir, randPic));
%         break;
%     end
% end
imgName = './rankingsvm/dataset/shooting/drawing/shooting-10.jpg';
img = imread(imgName);
img = rgb2gray(img);
% img = denoise(img);
% imgROI = findRect(img);
imgResized = resizeImage(img, tem_w, tem_h);
[imgAngle, imgMag] = im2gradient(imgResized);
matchingFeature = hierHog(imgResized);
cost = dist2(templateFeature, matchingFeature);
disp(['the cost is: ', num2str(cost)]);
% drawRect(imgAngle);