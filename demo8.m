% 合并所有的dat文件
trainDir = './rankingsvm/data/train/'; % test, index
dirList = dir(trainDir);
totaldir = length(dirList);
currentDir = num2str(totaldir);
for ii = 1:totaldir
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
    
% datDir = './rankingsvm/data/train/';
% dats = dir(datDir);
% totaldats = length(dats);
% fid = fopen('./rankingsvm/data/train/train.dat', 'w');
%     for i = 1:totaldats
%         if ~dats(i).isdir && ~strcmp(dats(i).name, 'train.dat')
%             file = strcat(datDir, dats(i).name);
%             datid = fopen(file, 'r');
%             data = fread(datid);
%             fwrite(fid, data);
%             fclose(datid);
%         end
%     end
%     fclose(fid);