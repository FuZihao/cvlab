% 读取特征文件，并生成训练集和测试集
clear;
dirfid =  fopen('./rankingsvm/dataset/dirnames.txt','r');
feature_dim = 5;
nfold = 4;
generateIndexCount = 1;
dirname = fgetl(dirfid);
while ischar(dirname)
    prefix = './rankingsvm/dataset/';
    featureDir = strcat(prefix, dirname, '/feature/');
    featureFile = strcat(featureDir, 'feature.dat');
    fid = fopen(featureFile, 'r');
    tline = fgetl(fid);
    totalImgs = sscanf(tline, '%d');
    featureData = zeros(totalImgs, feature_dim+2); % rank qid feature
    
    sample = fgetl(fid);
    for i = 1:totalImgs
        feature = sscanf(sample, '%d %d %f %f %f %f %f');
        featureData(i,:) = feature';
        sample = fgetl(fid);
    end
    
    for j = 1:generateIndexCount
        indexes = randperm(totalImgs); % 打乱样本顺序
        testsetCount = floor(totalImgs/nfold);
        for k = 1:nfold
            testIndex = [];
            trainIndex = [];
            for jj = 1:totalImgs
                if ((k-1)*testsetCount+1) <= jj && jj <= k*testsetCount
                    testIndex = [testIndex, indexes(jj)];
                else
                    trainIndex = [trainIndex, indexes(jj)];
                end
            end
            
            trainsetSize = size(trainIndex, 2);
            testsetSize = size(testIndex, 2);
            traindata = zeros(trainsetSize,feature_dim+2);
            testdata = zeros(testsetSize,feature_dim+2);
%             disp(['generating the fold ',num2str((j-1)*nfold + k),dirname,' feature data']);
%             strrep(dirname, '\n', '');
%             output = sprintf('%s generating the fold %d feature data',dirname,(j-1)*nfold + k);
%             disp(output);
            disp(['generating the fold ', num2str((j-1)*nfold + k), ' feature data']);
            for ii = 1:trainsetSize
%                 disp(['processing the number ',num2str(ii),' training picture']);
                traindata(ii,:) = featureData(trainIndex(ii), :);
            end
            
            for ii = 1:testsetSize
%                 disp(['processing the number ',num2str(ii),' testing picture']);
                testdata(ii,:) = featureData(testIndex(ii), :);
            end
            
            
            % 创建训练集文件夹
            subnum = (j-1)*nfold + k;
            subfolder = num2str(subnum);
            dir = strcat('./rankingsvm/data/train/', subfolder);
            if exist(dir, 'dir') == 0
                mkdir('./rankingsvm/data/train/', subfolder);
            end
            % 将数据矩阵写入文本，作为ranking svm 的输入
            trainPrefix =strcat('./rankingsvm/data/train/', subfolder, '/');
            trainFile = strcat(trainPrefix, dirname, 'Train.dat');
            ftrain = fopen(trainFile, 'w');

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
                    % feature 
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
                    % feature 
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
            picdir = strcat(prefix, dirname, '/');
            picFile = strcat(picdir, dirname, 'Names.txt');
            fpicname = fopen(picFile, 'r');
            
            allpics = [];
            tline = fgetl(fpicname);
            tline = fgetl(fpicname);
            while ischar(tline)
                allpics = [allpics; tline];
                tline = fgetl(fpicname);
            end
            fclose(fpicname);
            
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
               
                fprintf(findex, '%d ', rank);
                fprintf(findex, '%s\n', pic_name);
            end
            fclose(findex);
        end
    end
    dirname = fgetl(dirfid);
end