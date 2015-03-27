% 合并所有的dat文件
clear;
if 1
    trainDir = './rankingsvm/data/train/'; % test, index
    dirList = dir(trainDir);
    totaldir = length(dirList);
    % currentDir = num2str(totaldir);
    for ii = 1:totaldir-2 % 除去 . 和 ..
        currentDir = num2str(ii);
        datDir = strcat('./rankingsvm/data/train/', currentDir, '/');
        trainFile = strcat(datDir, 'train.dat');
        dats = dir(datDir);
        totaldats = length(dats);
        fid = fopen(trainFile, 'w');
        for i = 1:totaldats
            if ~dats(i).isdir && ~strcmp(dats(i).name, 'train.dat')
                file = strcat(datDir, dats(i).name);
                datid = fopen(file, 'r');
                data = fread(datid);
                fwrite(fid, data);
                fclose(datid);
            end
        end
        fclose(fid);
    end
end
if 1
    testDir = './rankingsvm/data/test/';
    dirList = dir(testDir);
    totaldir = length(dirList);
    % currentDir = num2str(totaldir);
    for ii = 1:totaldir-2 % 除去 . 和 ..
        currentDir = num2str(ii);
        datDir = strcat('./rankingsvm/data/test/', currentDir, '/');
        testFile = strcat(datDir, 'test.dat');
        dats = dir(datDir);
        totaldats = length(dats);
        fid = fopen(testFile, 'w');
        for i = 1:totaldats
            if ~dats(i).isdir && ~strcmp(dats(i).name, 'test.dat')
                file = strcat(datDir, dats(i).name);
                datid = fopen(file, 'r');
                data = fread(datid);
                fwrite(fid, data);
                fclose(datid);
            end
        end
        fclose(fid);
    end
end
if 1
    indexDir = './rankingsvm/data/index/';
    dirList = dir(indexDir);
    totaldir = length(dirList);
    % currentDir = num2str(totaldir);
    for ii = 1:totaldir-2 % 除去 . 和 ..
        currentDir = num2str(ii);
        datDir = strcat('./rankingsvm/data/index/', currentDir, '/');
        indexFile = strcat(datDir, 'index.dat');
        dats = dir(datDir);
        totaldats = length(dats);
        fid = fopen(indexFile, 'w');
        for i = 1:totaldats
            if ~dats(i).isdir && ~strcmp(dats(i).name, 'index.dat')
                file = strcat(datDir, dats(i).name);
                datid = fopen(file, 'r');
                data = fread(datid);
                fwrite(fid, data);
                fclose(datid);
            end
        end
        fclose(fid);
    end
end
