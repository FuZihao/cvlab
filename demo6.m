% 随机选取训练集和测试集
modelDir = './rankingsvm/dataset/shooting/model/';
drawingDir = './rankingsvm/dataset/shooting/drawing/';
templateName = 'shooting-00.jpg';

fid = fopen('./rankingsvm/dataset/shooting/shootingNames.txt', 'r');
tline = fgets(fid);
totalImgs = sscanf(tline, '%d');

% 提取模板图片特征
qid = 1;
templatePic = strcat(modelDir, templateName);
template = imread(templatePic);
tem = rgb2gray(template);
tem = denoise(tem);
[tem_w, tem_h] = findTemplateScale(tem);
[templateFeature, ind1, ind2, ind3, ind4, ind5]= hierHog(tem);
feature_dim = 5;

allpics = [];
tline = fgets(fid);
while ischar(tline)
    allpics = [allpics; tline];
    tline = fgets(fid);
end
indexes = randperm(totalImgs);
nfold = 5;
testsetCount = floor(totalImgs/nfold);
testIndex = [];
trainIndex = [];
i = 1;
for j = 1:totalImgs
    if ((i-1)*testsetCount+1) <= j && j <= i*testsetCount
        testIndex = [testIndex, indexes(j)];
    else
        trainIndex = [trainIndex, indexes(j)];
    end
end

trainsetSize = size(trainIndex, 2);
testsetSize = size(testIndex, 2);
traindata = zeros(trainsetSize,feature_dim+2);
for ii = 1:trainsetSize
    sample = allpics(trainIndex(ii),:);
    [nameAndRank] = sscanf(sample, '%s%d');
    count = size(nameAndRank, 1);
    nameAndRank = reshape(nameAndRank, [1,count]);
    picName = char(nameAndRank(1:count-1));
    rank = nameAndRank(count);
    disp(['processing the number ',num2str(ii),' training pic: ', picName]);
    img = imread(strcat(drawingDir, picName));
    img_gray = rgb2gray(img);
    tmp = hierHog(img_gray);
    matchingFeature = extractFeature(templateFeature, tmp, ind1, ind2, ind3, ind4, ind5);
    traindata(ii,1) = rank;
    traindata(ii,2) = qid;
    traindata(ii,3:feature_dim+2) = matchingFeature;
end
testdata = zeros(testsetSize,feature_dim+2);
for jj = 1:testsetSize
    sample = allpics(testIndex(jj),:);
    [nameAndRank] = sscanf(sample, '%s%d');
    count = size(nameAndRank, 1);
    nameAndRank = reshape(nameAndRank, [1,count]);
    picName = char(nameAndRank(1:count-1));
    rank = nameAndRank(count);
    disp(['processing the number ',num2str(jj),' testing pic: ', picName]);
    img = imread(strcat(drawingDir, picName));
    img_gray = rgb2gray(img);
    tmp = hierHog(img_gray);
    matchingFeature = extractFeature(templateFeature, tmp, ind1, ind2, ind3, ind4, ind5);
    testdata(jj,1) = rank;
    testdata(jj,2) = qid;
    testdata(jj,3:feature_dim+2) = matchingFeature;
end

% 将数据矩阵写入文本，作为ranking svm 的输入
ftrain = fopen('./rankingsvm/data/shootingTrain.dat', 'w');
%ftrain = fopen('./rankingsvm/dataset/archery/train.dat', 'w');
[trainrows, traincols] =  size(traindata);
for iii = 1:trainrows
    for jjj = 1:traincols
        if jjj == 1 % rank
            fprintf(ftrain,'%d ',traindata(iii,jjj));
            continue;
        end
        if jjj == 2 % qid
            fprintf(ftrain,'qid:%d ',traindata(iii,jjj));
            continue;
        end
        % feature pair
        fprintf(ftrain, '%d:%f',jjj-2, traindata(iii,jjj));
        if jjj ~= traincols
            fprintf(ftrain, ' ');
        end
    end
    if iii ~= trainrows
        fprintf(ftrain, '\n');
    end
end
fclose(ftrain);

ftest = fopen('./rankingsvm/data/shootingTest.dat', 'w');
[testrows, testcols] =  size(testdata);
for iii = 1:testrows
    for jjj = 1:testcols
        if jjj == 1 % rank
            fprintf(ftest,'%d ',testdata(iii,jjj));
            continue;
        end
        if jjj == 2 % qid
            fprintf(ftest,'qid:%d ',testdata(iii,jjj));
            continue;
        end
        % feature pair
        fprintf(ftest, '%d:%f',jjj-2, testdata(iii,jjj));
        if jjj ~= testcols
            fprintf(ftest, ' ');
        end
    end
    if iii ~= testrows
        fprintf(ftest, '\n');
    end
end
fclose(ftest);