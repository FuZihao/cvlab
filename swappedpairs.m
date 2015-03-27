function [ avgloss ] = swappedpairs(findex, fprediction)
% swappedpairs   计算swappedpairs
% findex         index文件的文件描述符
% fprediction    prediction文件的文件描述符

avgloss = 0;
qid = 0;
% findex = fopen('./rankingsvm/data/index/4/index.dat', 'r');
% fprediction = fopen('./rankingsvm/data/result/prediction4', 'r');

indexLine = fgets(findex);
while ischar(indexLine)
    picNumOfQuery = sscanf(indexLine, '%d');
    qid = qid + 1;
    scores = zeros(1, picNumOfQuery);
    ranks = zeros(1, picNumOfQuery);
    for i = 1:picNumOfQuery
        indexLine = fgetl(findex);
        ranks(i) = sscanf(indexLine, '%d');
        
        predictionLine = fgetl(fprediction);
        scores(i) = sscanf(predictionLine, '%f');
    end
    totpairs = 0;
    sum = 0;
    loss = 0;
    for ii = 1:picNumOfQuery
        for jj = 1:picNumOfQuery
            if ranks(ii) > ranks(jj)
                totpairs = totpairs + 1;
                if scores(ii) <= scores(jj)
                    sum = sum + 1;
                end
            end
        end
    end
    if totpairs
        loss = sum / totpairs;
    end
    avgloss = avgloss + loss;
    indexLine = fgets(findex);
end
avgloss = avgloss / qid;

% fclose(findex);
% fclose(fprediction);

end