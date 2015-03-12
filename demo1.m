% 将指定目录下的所有文件名写入文本，作下一步标注使用
% drawingDir = './dataset/shooting/';
% imgs = dir(drawingDir);
% totalImgs = length(imgs);
% fid = fopen('picNames.txt', 'w');
% for i = 1:totalImgs
%     if ~imgs(i).isdir
%         fprintf(fid, '%s', imgs(i).name);
%         if i ~= totalImgs
%             fprintf(fid, '\n');
%         end
%     end
% end
% fclose(fid);

% 根据文件中的图片名和rank，提取对应的特征，并保存
modelDir = './dataset/shooting/';
drawingDir = './dataset/shooting/';
templateName = 'shooting-00.jpg';
fid = fopen('picNames.txt', 'r');
index = 0;

tline = fgets(fid);
totalImgs = sscanf(tline, '%d');
templatePic = strcat(modelDir, templateName);
template = imread(templatePic);
tem = rgb2gray(template);
tem = denoise(tem);
[tem_w, tem_h] = findTemplateScale(tem);
templateFeature = hierHog(tem);
feature_dim = size(templateFeature, 2);
data = zeros(totalImgs,feature_dim); % 减去 .和 ..文件

tline = fgets(fid);
while ischar(tline)
    index = index + 1;
    [nameAndRank] = sscanf(tline, '%s%d');
    count = size(nameAndRank, 1);
    nameAndRank = reshape(nameAndRank, [1,count]);
    picName = char(nameAndRank(1:count-1));
    rank = nameAndRank(count);
    if strcmp(picName, templateName)
        data(index,1) = rank;
        data(index,2:feature_dim+1) = templateFeature;
    end
    img = imread(strcat(drawingDir, picName));
    img_gray = rgb2gray(img);
    img_gray = denoise(img_gray);
    img_gray = resizeImage(img_gray, tem_w, tem_h);
    tmp = hierHog(img_gray);
    data(index,1) = rank;
    data(index,2:feature_dim+1) = tmp;
    tline = fgets(fid);
end
fclose(fid);

% 将数据矩阵写入文本，作为ranking svm 的输入
% f = fopen('mytest.txt', 'w');
% m = magic(8);
% [rows, cols] = size(m);
% for i = 1:rows
%     for j = 1:cols
%         fprintf(f, '%d:%f',j, m(i,j));
%         if j ~= cols
%             fprintf(f, ' ');
%         end
%     end
%     if i ~= rows
%         fprintf(f, '\n');
%     end
% end
% fclose(f);