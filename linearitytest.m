clear;
indexDirPrefix = './rankingsvm/data/index/4/'; % 测试索引所在的目录
resultDir = './rankingsvm/data/result/';

indexName = 'archeryIndex.dat';
predictionName = 'prediction4';
indexFile = strcat(indexDirPrefix, indexName);
predictionFile = strcat(resultDir, predictionName);

fprediction = fopen(predictionFile, 'r');
findex = fopen(indexFile, 'r');
indexLine = fgetl(findex);
skipLineCount = 0;
for ii = 1: skipLineCount
    disp('hello');
end
picNumOfQuery = sscanf(indexLine, '%d');
ranks = zeros(1, picNumOfQuery);
scores = zeros(1, picNumOfQuery);
for i = 1:picNumOfQuery
    indexLine = fgetl(findex);
    predictionLine = fgetl(fprediction);
    ranks(i) = sscanf(indexLine, '%d %*s');
    scores(i) = sscanf(predictionLine, '%f');
end
fclose(findex);
fclose(fprediction);
plot(scores, ranks, 'b.');

