% 提取图片中手绘图的区域

processDir = './dataset/fencing/';
picNames = dir(processDir);
picCount = length(picNames);

templateName = strcat(processDir, 'fencing-00.jpg');
template = imread(templateName);
template = rgb2gray(template);
temROI = findRect(template);
[tem_w, tem_h] = findTemplateScale(template);
% figure(1);
% imshow(template);
% hold on;
% rectangle('Position',temROI,'Curvature',[0,0],'LineWidth',2,'LineStyle','--','EdgeColor','r');
% hold off;
temResized = resizeImage(template, tem_w, tem_h);
% drawRect(temResized);
% imshow(temResized);
[angle, magnitude] = im2gradient(temResized);

while true
    randNum = randi([1, picCount-2]);
    randPic = picNames(randNum).name;
    if ~isdir(randPic)
        img = imread(strcat(processDir,randPic));
        break;
    end
end

% imgName = './dataset/archery/archery-00.jpg';
% img =  imread(imgName);
% img = rgb2gray(img);
% % img = denoise(img);
% ROI = findRect(img);
% figure(2);
% imshow(img);
% hold on;
% rectangle('Position',ROI,'Curvature',[0,0],'LineWidth',2,'LineStyle','--','EdgeColor','r');
% hold off;
% impixelinfo;

% imgExtracted = zeros(ROI(4),ROI(3));
% imgExtracted = im2uint8(imgExtracted);
% % imgExtracted = 255 - imgExtracted;
% imgExtracted(1:ROI(4), 1:ROI(3)) = img(ROI(2):ROI(2)+ROI(4)-1,ROI(1):ROI(1)+ROI(3)-1);
% figure(3);
% imshow(imgExtracted); 
% 
% diff = imgExtracted - img(ROI(2):ROI(2)+ROI(4)-1,ROI(1):ROI(1)+ROI(3)-1);
% figure(4);
% imshow(diff);
% imgResized = resizeImage(img, tem_w, tem_h);
% figure(3);
% imshow(imgResized);
