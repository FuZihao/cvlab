% 使用不同的参数进行训练
clear;
tradeoff = '-c ';
tradeoffValue = [50, 20, 10, 3, 2, 1, 0.5, 0.1, 0.05, 0.01, 0.001];
totalIter = size(tradeoffValue, 2);
generateIndexCount = 1;
error = [];
count = [];
meanErrorPerIter = [];
maxErrorPerIter = [];
minErrorPerIter = [];
varianceErrorPerIter = [];

trainDir = './rankingsvm/data/train/'; % test, index
dirList = dir(trainDir);
totaldir = length(dirList);
totaldir = totaldir -2; % 除去 .和..
% currentDir = num2str(totaldir);
% totalIter = 1; % 测试
for j = 1:generateIndexCount
    for iter = 1:totalIter
        tradeoffValue_c = num2str(tradeoffValue(iter));
        tradeoffValue_c = [tradeoffValue_c, ' '];
        trainParas = [tradeoff, tradeoffValue_c];
        

        errorPerDir = [];
        countPerDir = [];
        %     totaldir = 1; % 测试
        for i = 1:totaldir
            disp(['Iteration: ',num2str(iter), ' TrainSet: ', num2str(i)]);
            currentDir = num2str(i);
            trainDir = strcat('rankingsvm\data\train\', currentDir, '\');
            %         trainFile = 'rankingsvm\data\train.dat rankingsvm\example3\model ';
            trainFile = strcat(trainDir, 'train.dat');
            resultDir = ' rankingsvm\data\result\';
            modelFile = strcat(resultDir, 'model', currentDir);
            
            fileParas = strcat(trainFile, modelFile);
            trainEXE = 'rankingsvm\svm_rank_learn.exe ';
            trainArgs = [trainEXE, trainParas, fileParas];
            [trainsTatus, trainOutput]=dos(trainArgs);
            
            %         testFile = 'rankingsvm\example3\test.dat rankingsvm\example3\model rankingsvm\example3\predictions ';
            testDir = strcat('rankingsvm\data\test\', currentDir, '\');
            testFile = strcat(testDir, 'test.dat');
            predictionFile = strcat(resultDir, 'prediction', currentDir);
            %         classifyParas = strcat(testFile, modelFile, ' ', predictionFile);
            classifyParas = [testFile, ' ', modelFile, ' ', predictionFile];
            testEXE = 'rankingsvm\svm_rank_classify.exe ';
            testArgs = [testEXE, classifyParas];
            %         testArgs = strcat(testEXE, classifyParas);
            [testTatus, testOutput] = dos(testArgs);
            
            fresult = fopen('stats.txt','r');
            tline = fgets(fresult);
            swappedpairs = sscanf(tline, '%f');
            errorPerDir = [errorPerDir, swappedpairs];
            countPerDir = [countPerDir, (iter-1)*totaldir+i];
            fclose(fresult);
        end
        meanErrorPerIter = [meanErrorPerIter, mean(errorPerDir)];
        maxErrorPerIter = [maxErrorPerIter, max(errorPerDir)];
        minErrorPerIter = [minErrorPerIter, min(errorPerDir)];
        varianceErrorPerIter = [varianceErrorPerIter, sum((errorPerDir(1,:)-mean(errorPerDir)).^2)/length(errorPerDir)];
        count = [count, iter];
    end
end
figure;
subplot(1,2,1);
plot(count, meanErrorPerIter, '-b.');
axis([0 15 0.1 0.2]);
set(gca, 'xtick',(0:1:15));
set(gca, 'ytick',(0.1:0.005:0.2));

subplot(1,2,2);
plot(count, varianceErrorPerIter, '-r.');

resultDir = './rankingsvm/data/result/';
statusFile = strcat(resultDir, 'status.dat');
fstatus = fopen(statusFile, 'w');
for i = totalIter
    fprintf(fstatus, 'tradeoff value: %f\n', tradeoffValue(i));
    fprintf(fstatus, 'mean error: %f ', meanErrorPerIter(i));
    fprintf(fstatus, 'variance: %f\n', varianceErrorPerIter(i));
end
fclose(fstatus);