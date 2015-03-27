% 随机选取训练集和测试集
dirfid =  fopen('./rankingsvm/dataset/dirnames.txt','r');

qid = 0;
dirname = fgets(dirfid);
while ischar(dirname)

    prefix = './rankingsvm/dataset/';
    modelDir = strcat(prefix, dirname, '/model/');
    drawingDir = strcat(prefix, dirname, '/drawing/');
    templateName = strcat(dirname, '-00.jpg');
    
    picdir = strcat(prefix, dirname, '/');
    picFile = strcat(picdir, dirname, 'Names.txt');
    % fid = fopen('./rankingsvm/dataset/shooting/shootingNames.txt', 'r');
    fid = fopen(picFile, 'r');
    tline = fgets(fid);
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
    tline = fgets(fid);
    while ischar(tline)
        allpics = [allpics; tline];
        tline = fgets(fid);
    end
    indexes = randperm(totalImgs); % 打乱样本顺序
    nfold = 5;
    testsetCount = floor(totalImgs/nfold);
%     i = 1;
    for i = 1:nfold
        testIndex = [];
        trainIndex = [];
        
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
            img_gray = resizeImage(img_gray, tem_w, tem_h); % 此处更改了
            
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
            img_gray = resizeImage(img_gray, tem_w, tem_h); % 此处更改了
            
            tmp = hierHog(img_gray);
            matchingFeature = extractFeature(templateFeature, tmp, ind1, ind2, ind3, ind4, ind5);
            testdata(jj,1) = rank;
            testdata(jj,2) = qid;
            testdata(jj,3:feature_dim+2) = matchingFeature;
        end
        
        % 创建训练集文件夹
        subfolder = num2str(i);
        dir = strcat('./rankingsvm/data/train/', subfolder);
        if exist(dir, 'dir') == 0
            mkdir('./rankingsvm/data/train/', subfolder);
        end
        % 将数据矩阵写入文本，作为ranking svm 的输入
        trainPrefix =strcat('./rankingsvm/data/train/', subfolder, '/');
        trainFile = strcat(trainPrefix, dirname, 'Train.dat');
        ftrain = fopen(trainFile, 'w');
        % ftrain = fopen('./rankingsvm/data/shootingTrain.dat', 'w');
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
            % 为了更好的合并文件，所以每行都输入换行符
            %     if iii ~= trainrows
            fprintf(ftrain, '\n');
            %     end
        end
        fclose(ftrain);
        
        dir = strcat('./rankingsvm/data/test/', subfolder);
        if exist(dir, 'dir') == 0
            mkdir('./rankingsvm/data/test/', subfolder);
        end
        testPrefix = strcat('./rankingsvm/data/test/', subfolder, '/');
        testFile = strcat(testPrefix, dirname, 'Test.dat');
        ftest = fopen(testFile, 'w');
        % ftest = fopen('./rankingsvm/data/shootingTest.dat', 'w');
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
            % 为了更好的合并文件，所以每行都输入换行符
            %     if iii ~= testrows
            fprintf(ftest, '\n');
            %     end
        end
        fclose(ftest);
        
        % 把索引，分值和图片名存入文本，作以后分析
        dir = strcat('./rankingsvm/data/index/', subfolder);
        if exist(dir, 'dir') == 0
            mkdir('./rankingsvm/data/index/', subfolder);
        end
        indexPrefix = strcat('./rankingsvm/data/index/', subfolder, '/');
        indexFile = strcat(indexPrefix, dirname, 'Index.dat');
        findex = fopen(indexFile, 'w');
        fprintf(findex, '%d\n', testsetSize);
        for n = 1:testsetSize
            s = allpics(testIndex(n),:);
            [name_and_rank] = sscanf(s, '%s%d');
            count = size(name_and_rank, 1);
            name_and_rank = reshape(name_and_rank, [1,count]);
            pic_name = char(name_and_rank(1:count-1));
            rank = name_and_rank(count);
%             fprintf(findex, '%d ', testsetSize);
            fprintf(findex, '%d ', rank);
            fprintf(findex, '%s\n', pic_name);
        end
        fclose(findex);
    end
    dirname = fgets(dirfid);
end