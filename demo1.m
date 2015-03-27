% 随机选取训练集和测试集
clear;
dirfid =  fopen('./rankingsvm/dataset/dirnames.txt','r');

qid = 0;
dirname = fgetl(dirfid);
while ischar(dirname)
    
    prefix = './rankingsvm/dataset/';
    modelDir = strcat(prefix, dirname, '/model/');
    drawingDir = strcat(prefix, dirname, '/drawing/');
    templateName = strcat(dirname, '-00.jpg');
    
    picdir = strcat(prefix, dirname, '/');
    picFile = strcat(picdir, dirname, 'Names.txt');
    fid = fopen(picFile, 'r');
    tline = fgetl(fid);
    totalImgs = sscanf(tline, '%d');
    
    % 提取模板图片特征
    qid = qid + 1;
    templatePic = strcat(modelDir, templateName);
    template = imread(templatePic);
    tem = rgb2gray(template);
    %     tem = denoise(tem); % 用不同的选项测试效果
    [tem_w, tem_h] = findTemplateScale(tem);
    temResized = resizeImage(tem, tem_w, tem_h);
    [templateFeature, ind1, ind2, ind3, ind4, ind5]= hierHog(temResized);
    feature_dim = 5;
    
    allpics = [];
    tline = fgetl(fid);
    while ischar(tline)
        allpics = [allpics; tline];
        tline = fgetl(fid);
    end
    
    featureData = zeros(totalImgs,feature_dim+2);
    for i = 1:totalImgs
        sample = allpics(i,:);
        [nameAndRank] = sscanf(sample, '%s%d');
        count = size(nameAndRank, 1);
        nameAndRank = reshape(nameAndRank, [1,count]);
        picName = char(nameAndRank(1:count-1));
        rank = nameAndRank(count);
        disp(['extracting the number ',num2str(i),' picture feature: ', picName]);
        img = imread(strcat(drawingDir, picName));
        img_gray = rgb2gray(img);
        img_gray = resizeImage(img_gray, tem_w, tem_h); % 此处更改了
        
        tmp = hierHog(img_gray);
        matchingFeature = extractFeature(templateFeature, tmp, ind1, ind2, ind3, ind4, ind5);
        featureData(i,1) = rank;
        featureData(i,2) = qid;
        featureData(i,3:feature_dim+2) = matchingFeature;
    end
    
    % 将数据矩阵写入文本，作为ranking svm 的输入
    featureDir = strcat(picdir, 'feature/');
    featureFile = strcat(featureDir, 'feature.dat');
    ffeature = fopen(featureFile, 'w');
    fprintf(ffeature, '%d\n', totalImgs); % 该目录下图片的数量
    [rows, cols] =  size(featureData);
    for ii = 1:rows
        for jj = 1:cols
            if jj == 1 % rank
                fprintf(ffeature,'%d ',featureData(ii,jj));
                continue;
            end
            if jj == 2 % qid
                fprintf(ffeature,'%d ',featureData(ii,jj));
                continue;
            end
            % feature pair
            fprintf(ffeature, '%f', featureData(ii,jj));
            if jj ~= cols
                fprintf(ffeature, ' ');
            end
        end
        % 为了更好的合并文件，所以每行都输入换行符
        %     if iii ~= trainrows
        fprintf(ffeature, '\n');
        %     end
    end
    fclose(ffeature);
    
    dirname = fgetl(dirfid);
end