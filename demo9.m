% 读取测试集文件和预测文件，并生成重新排序后的图片名文件
findex = fopen('./rankingsvm/data/test/index.dat', 'r');
fprediction = fopen('./rankingsvm/data/test/prediction.dat', 'r');
fresult = fopen('./rankingsvm/data/test/result.dat', 'w');

indexLine = fgets(findex);
while ischar(indexLine)
    picNumOfQuery = sscanf(indexLine, '%d');
    queryPics = [];
%     predictions = [];
    scores = zeros(1, picNumOfQuery);
    for i = 1:picNumOfQuery
        indexLine = fgetl(findex);
        queryPics = [queryPics; indexLine];
        
        predictionLine = fgetl(fprediction);
%         predictions = [predictions; predictionLine];
        scores(i) = sscanf(predictionLine, '%f');
%         score = sscanf(predictionLine, '%f');
    end
    [B,I] = sort(scores, 'descend');
    for j = 1:picNumOfQuery
        tmp = queryPics(I(j),:);
        fprintf(fresult, '%s %s ', tmp);
        fprintf(fresult, '%f\n', B(j));
    end
    indexLine = fgets(findex);
end

fclose(findex);
fclose(fprediction);
fclose(fresult);