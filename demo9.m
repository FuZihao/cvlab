% ��ȡ���Լ��ļ���Ԥ���ļ�������������������ͼƬ���ļ�
clear;
findex = fopen('./rankingsvm/data/index/1/index.dat', 'r');
fprediction = fopen('./rankingsvm/data/result/prediction1', 'r');
fresult = fopen('./rankingsvm/data/result/result', 'w');

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