    % ��ָ��Ŀ¼�µ������ļ���д���ı�������һ����עʹ��
    drawingDir = './rankingsvm/dataset/triathlon/drawing';
    imgs = dir(drawingDir);
    totalImgs = length(imgs);
    fid = fopen('./rankingsvm/dataset/triathlon/triathlonNames.txt', 'w');
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