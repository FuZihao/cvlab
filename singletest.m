clear;
indexDirPrefix = './rankingsvm/data/index/'; % 测试索引所在的目录
resultDir = './rankingsvm/data/result/';
dirList = dir(indexDirPrefix);
totaldir = length(dirList);
totaldir = totaldir -2; % 除去 .和..
errorPerDirSVM = [];
errorPerDirCos = [];
for i = 1:totaldir
        currentDir = num2str(i);
        indexDir = strcat(indexDirPrefix, currentDir, '/');
        indexFile = strcat(indexDir, 'index.dat');
        findex = fopen(indexFile, 'r');
        predictionFileWithCos = strcat(resultDir, 'predictionCosine', currentDir);
        
        predictionFileWithSVM = strcat(resultDir, 'prediction', currentDir);
        fprediction = fopen(predictionFileWithSVM, 'r');
        misSVM = swappedpairs(findex, fprediction);
        fclose(findex);
        index = fopen(indexFile, 'r');
        fpredictionCos = fopen(predictionFileWithCos, 'r');
        misCos = swappedpairs(findex, fpredictionCos);
        errorPerDirSVM = [errorPerDirSVM, misSVM];
        errorPerDirCos = [errorPerDirCos, misCos];
        
        
        fclose(fprediction);
        fclose(fpredictionCos);
end
meanSVM = mean(errorPerDirSVM);
meanCos = mean(errorPerDirCos);
str_SVM = sprintf('meanSVM: %f ', meanSVM);
str_Cos = sprintf('meanCos: %f', meanCos);
disp(str_SVM);
disp(str_Cos);
