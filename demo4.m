% ƽ����Ĳ������в���
clear;
totalIter = 1; % ����

for iter = 1:totalIter
    totaldir = 1; % ����
    for i = 1:totaldir
        resultDir = 'rankingsvm\tmp\';
        testDir = strcat('rankingsvm\tmp\');
        testFile = strcat(testDir, 'alltest.txt');
        predictionFile = strcat(resultDir, 'prediction');
        modelFile = strcat(resultDir,'meanModel.txt');
        classifyParas = [testFile, ' ', modelFile, ' ', predictionFile];
        testEXE = 'rankingsvm\svm_rank_classify.exe ';
        testArgs = [testEXE, classifyParas];
        
        [testTatus, testOutput] = dos(testArgs);
        
        fresult = fopen('stats.txt','r');
        tline = fgets(fresult);
        swappedpairs = sscanf(tline, '%f');
        output = sprintf('swappedpairs is: %f', swappedpairs);
        disp(output);
        fclose(fresult);
    end
end
