% 使用不同的参数进行训练
tradeoff = '-c ';
tradeoffValue = [3, 2, 1];
error = [];
count = [];
for iter = 1:3
    tradeoffValue_c = num2str(tradeoffValue(iter));
    tradeoffValue_c = [tradeoffValue_c, ' '];
    trainParas = [tradeoff, tradeoffValue_c];
    trainFile = 'rankingsvm\example3\train.dat rankingsvm\example3\model ';
    trainEXE = 'rankingsvm\svm_rank_learn.exe ';
    trainArgs = [trainEXE, trainParas, trainFile];
    [trainsTatus, trainOutput]=dos(trainArgs);
    
    testFile = 'rankingsvm\example3\test.dat rankingsvm\example3\model rankingsvm\example3\predictions ';
    testEXE = 'rankingsvm\svm_rank_classify.exe ';
    testArgs = [testEXE, testFile];
    [testTatus, testOutput] = dos(testArgs);
    
    fresult = fopen('stats.txt','r');
    tline = fgets(fresult);
    swappedpairs = sscanf(tline, '%d');
    error = [error, swappedpairs];
    count = [count, iter];
    fclose(fresult);
end
plot(count, error, 'b.');
