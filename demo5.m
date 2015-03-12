    % 将指定目录下的所有文件名写入文本，作下一步标注使用
    drawingDir = './rankingsvm/dataset/triathlon/drawing';
    imgs = dir(drawingDir);
    totalImgs = length(imgs);
    fid = fopen('./rankingsvm/dataset/triathlon/triathlonNames.txt', 'w');
    fprintf(fid, '%d\n', totalImgs-2); % 该目录下图片的数量
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