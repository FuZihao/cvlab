% 试验步骤分两部分，根据需要注释不需要的部分
% 步骤一
% modelDir = './dataset/test/model/';
% drawingDir = './dataset/test/drawing/';
% picName = 'golf-00.jpg';
both = 1;
if both
%     clear;
%     processed_dir = './dataset/skiing/';
%     template_name = './dataset/skiing/skiing-00.jpg'; % 每个类别下的第一张图片为模板图
%     modelDir = './dataset/test/model/';
%     drawingDir = './dataset/test/drawing/';
%     picName = 'gymnastics-00.jpg';

    modelDir = './dataset/shooting/';
    drawingDir = './dataset/shooting/';
    picName = 'shooting-00.jpg';

    templatePic = strcat(modelDir, picName);
    %feature_dim = 1584;
%     imgs = dir(processed_dir);
    imgs = dir(drawingDir);
    img_num = length(imgs);
    template = imread(templatePic);
    tem = rgb2gray(template);
%     tem = denoise(tem);
    [tem_w, tem_h] = findTemplateScale(tem);
    temResized = resizeImage(tem, tem_w, tem_h);
    templateFeature = hierHog(temResized);
    feature_dim = size(templateFeature, 2);
    data = zeros(img_num-2,feature_dim); % 减去 .和 ..文件
    
    for i = 3:img_num %  跳过 . 和 .. 文件
        img = imread(strcat(drawingDir, imgs(i).name));
        disp(['processing the number ',num2str(i-2),' pic: ', imgs(i).name]);
        img_gray = rgb2gray(img);
%         img_gray = denoise(img_gray);
        
        img_gray = resizeImage(img_gray, tem_w, tem_h);
        tmp = hierHog(img_gray);
        data(i-2,:) = tmp;
    end
    disp('done!');
    % save('data', 'data');
end

% 步骤二
% ranking = zeros(1,img_num-3); % 减去模板， . 和 .. 文件
ranking = zeros(1, img_num-2); % 减去 . 和 .. 文件
for i = 1:img_num-2
%     cost = dist(data(1,:),data(i+1,:)); % 需要度量的图片从第二张开始
    cost = dist2(templateFeature, data(i, :));
    ranking(i) = cost;
end
%     cost = dist(templateFeature, templateFeature);
%     ranking(img_num-1) = cost;
    
[B,I] = sort(ranking);
figure;
for i =1:20
    img = imread(strcat(drawingDir, imgs(I(i)+2).name)); % 跳过 . 和 .. 文件
    subplot(4,5,i);
    imshow(img);
    title(imgs(I(i)+2).name);
end

