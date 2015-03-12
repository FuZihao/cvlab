both = 0;
if both
    % ��ָ��Ŀ¼�µ������ļ���д���ı�������һ����עʹ��
    drawingDir = './dataset/archery/';
    imgs = dir(drawingDir);
    totalImgs = length(imgs);
    fid = fopen('picNames.txt', 'w');
    fprintf(fid, '%d\n', totalImgs); % ��Ŀ¼��ͼƬ������
    for i = 1:totalImgs
        if ~imgs(i).isdir
            fprintf(fid, '%s', imgs(i).name);
            if i ~= totalImgs
                fprintf(fid, '\n');
            end
        end
    end
    fclose(fid);
else
    % �����ļ��е�ͼƬ����rank����ȡ��Ӧ��������������
    modelDir = './dataset/archery/';
    drawingDir = './dataset/archery/';
    templateName = 'archery-00.jpg';
    train = 0;
    if train
        fid = fopen('trainPic.txt', 'r');
    else
        fid = fopen('testPic.txt', 'r');
    end
    index = 0;
    qid = 1;
    
    tline = fgets(fid);
    totalImgs = sscanf(tline, '%d');
    templatePic = strcat(modelDir, templateName);
    template = imread(templatePic);
    tem = rgb2gray(template);
    tem = denoise(tem);
    [tem_w, tem_h] = findTemplateScale(tem);
    [templateFeature, ind1, ind2, ind3, ind4, ind5]= hierHog(tem);
    % feature_dim = size(templateFeature, 2);
    feature_dim = 5;
    data = zeros(totalImgs-1,feature_dim+2); % ȥ��templatePic������rank��qid
    
    tline = fgets(fid);
    while ischar(tline)
        %     index = index + 1;
        [nameAndRank] = sscanf(tline, '%s%d');
        count = size(nameAndRank, 1);
        nameAndRank = reshape(nameAndRank, [1,count]);
        picName = char(nameAndRank(1:count-1));
        rank = nameAndRank(count);
        if strcmp(picName, templateName) % templatePic��һ��Ҫ�ڵ�һ��λ��
            %         data(index,1) = rank;
            %         data(index,2:feature_dim+1) = templateFeature;
            tline = fgets(fid);
            continue;
        end
        index = index+1;
        img = imread(strcat(drawingDir, picName));
        disp(['processing the number ',num2str(index),' pic: ', picName]);
        img_gray = rgb2gray(img);
        %     img_gray = denoise(img_gray);
        img_gray = resizeImage(img_gray, tem_w, tem_h);
        tmp = hierHog(img_gray);
        matchingFeature = extractFeature(templateFeature, tmp, ind1, ind2, ind3, ind4, ind5);
        data(index,1) = rank;
        data(index,2) = qid;
        data(index,3:feature_dim+2) = matchingFeature;
        tline = fgets(fid);
    end
    fclose(fid);
    
    % �����ݾ���д���ı�����Ϊranking svm ������
    if train
        f = fopen('train.dat', 'w');
    else
        f = fopen('test.dat', 'w');
    end
    [rows, cols] =  size(data);
    for i = 1:rows
        for j = 1:cols
            if j == 1 % rank
                fprintf(f,'%d ',data(i,j));
                continue;
            end
            if j == 2 % qid
                fprintf(f,'qid:%d ',data(i,j));
                continue;
            end
            % feature pair
            fprintf(f, '%d:%f',j-2, data(i,j));
            if j ~= cols
                fprintf(f, ' ');
            end
        end
        if i ~= rows
            fprintf(f, '\n');
        end
    end
    fclose(f);
    
end