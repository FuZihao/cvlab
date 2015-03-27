% ʹ��������������ͬ���Ĳ��Լ�����ranking scores

indexDirPrefix = './rankingsvm/data/index/'; % �����������ڵ�Ŀ¼
% dirfid =  fopen('./rankingsvm/dataset/dirnames.txt','r'); % ��ȡģ��ͼƬ��

resultDir = './rankingsvm/data/result/';
prefix = './rankingsvm/dataset/';

dirList = dir(indexDirPrefix);
totaldir = length(dirList);
totaldir = totaldir -2; % ��ȥ .��..
totalIter = 1; % ����
for iter = 1:totalIter
    errorPerDir = [];
    countPerDir = [];
%     scores = [];
    swappedpairs = [];
    for i = 1:totaldir
        currentDir = num2str(i);
        indexDir = strcat(indexDirPrefix, currentDir, '/');
        indexFile = strcat(indexDir, 'index.dat');
        findex = fopen(indexFile, 'r');
        predictionFile = strcat(resultDir, 'predictionCosine', currentDir);% Ԥ���ļ�
        fprediction = fopen(predictionFile, 'w');
        
        dirfid =  fopen('./rankingsvm/dataset/dirnames.txt','r'); % ��ȡģ��ͼƬ��
        dirname = fgetl(dirfid);
        while ischar(dirname)
            prefix = './rankingsvm/dataset/';
            modelDir = strcat(prefix, dirname, '/model/');
            drawingDir = strcat(prefix, dirname, '/drawing/');
            templateName = strcat(dirname, '-00.jpg'); % ģ��ͼ��
            templatePic = strcat(modelDir, templateName);
            template = imread(templatePic);
            tem = rgb2gray(template);
            [tem_w, tem_h] = findTemplateScale(tem);
            temResized = resizeImage(tem, tem_w, tem_h);
            [templateFeature, ind1, ind2, ind3, ind4, ind5]= hierHog(temResized);
    
            indexLine = fgetl(findex);
            picNumOfQuery = sscanf(indexLine, '%d');
%             scores = zeros(1, picNumOfQuery);
            for ii = 1:picNumOfQuery
                indexLine = fgetl(findex);
                matchingPicNameInNum = sscanf(indexLine, '%*d %s');
                matchingPicName = char(matchingPicNameInNum');
                disp(matchingPicName);
                img = imread(strcat(drawingDir, matchingPicName));
                img_gray = rgb2gray(img);
                img_gray = resizeImage(img_gray, tem_w, tem_h);
                matchingPicFeature = hierHog(img_gray);
                scores = dist(templateFeature, matchingPicFeature, ind1, ind2, ind3, ind4, ind5);
                fprintf(fprediction, '%f\n', 1-scores);
            end
            dirname = fgetl(dirfid);
        end
        fclose(fprediction);
        fclose(dirfid);
    end
end
