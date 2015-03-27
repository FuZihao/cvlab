    % ��ָ��Ŀ¼�µ������ļ���д���ı�������һ����עʹ��
    dataDir = './rankingsvm/dataset/';
    dirs = dir(dataDir);
    totalDirs = length(dirs);
    for ii = 1:totalDirs
        if ~dirs(ii).isdir || strcmp(dirs(ii).name, '.') || strcmp(dirs(ii).name, '..')
            continue;
        end
        
        drawingDir = strcat(dataDir, dirs(ii).name, '/drawing/');
        imgs = dir(drawingDir);
        totalImgs = length(imgs);
        nameFileDir = strcat(dataDir, dirs(ii).name, '/');
        fileName = strcat(nameFileDir, dirs(ii).name, 'Name.txt');
        fid = fopen(fileName, 'w');
        fprintf(fid, '%d\n', totalImgs-2); % ��Ŀ¼��ͼƬ������
        for i = 1:totalImgs
            if ~imgs(i).isdir
                fprintf(fid, '%s', imgs(i).name);
                %             if i ~= totalImgs
                %                 fprintf(fid, '\n');
                %             end
                fprintf(fid, '\n');
            end
        end
        fclose(fid);
        
    end
    
