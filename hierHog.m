function [ features, ind11, ind12, ind2, ind3, ind4 ] = hierHog(im)
%   提取不同层的梯度特征
%   im 输入的图片
%   features 输出的特征向量，本实验总共1584维
%   ind11, ind12, ind2, ind3, ind4分别为每层特征的最后索引

im3 = impyramid(im, 'reduce');
im2 = impyramid(im3, 'reduce');
im1 = impyramid(im2, 'reduce');
approach = 0; % 0 is my approach
if approach
    [y1,x1] = size(im1);
    features_level11 = extractHOGFeatures(im1,'CellSize',[y1 floor(x1/2)],...
                                                'BlockSize',[1 2],...
                                                'BlockOverlap',[0 0],...
                                                'NumBins',18,...
                                                'UseSignedOrientation',true);
    features_level12 = extractHOGFeatures(im1,'CellSize',[floor(y1/2) x1],...
                                                'BlockSize',[2 1],...
                                                'BlockOverlap',[0 0],...
                                                'NumBins',18,...
                                                'UseSignedOrientation',true);
                                            
    [y2,x2] = size(im2);
    features_level2 = extractHOGFeatures(im2,'CellSize',[floor(y2/2) floor(x2/2)],...
                                                'BlockSize',[2 2],...
                                                'BlockOverlap',[0 0],...
                                                'NumBins',18,...
                                                'UseSignedOrientation',true);

    [y3,x3] = size(im3);
    features_level3 = extractHOGFeatures(im3,'CellSize',[floor(y3/4) floor(x3/4)],...
                                                'BlockSize',[2 2],...
                                                'BlockOverlap',[0 0],...
                                                'NumBins',18,...
                                                'UseSignedOrientation',true);
    [y4,x4] = size(im);
    features_level4 = extractHOGFeatures(im,'CellSize',[floor(y4/8) floor(x4/8)],...
                                                'BlockSize',[2 2],...
                                                'BlockOverlap',[0 0],...
                                                'NumBins',18,...
                                                'UseSignedOrientation',true);
else
    [y1,x1] = size(im1);
    features_level11 = myHOG(im1, [y1 floor(x1/2)], [1 2], [0 0], 18, 1);
    features_level12 = myHOG(im1,[floor(y1/2) x1], [2 1], [0 0], 18, 1);
                                            
    [y2,x2] = size(im2);
    features_level2 = myHOG(im2, [floor(y2/2) floor(x2/2)], [2 2], [0 0], 18, 1);

    [y3,x3] = size(im3);
    features_level3 = myHOG(im3, [floor(y3/4) floor(x3/4)], [2 2], [0 0], 18, 1);
    % 设blockOverlap
    %features_level3 = myHOG(im3, [floor(y3/4) floor(x3/4)], [2 2], [1 1], 18, 1);
    [y4,x4] = size(im);
    features_level4 = myHOG(im, [floor(y4/8) floor(x4/8)],[2 2],[0 0], 18, 1);
    % 设blockOverlap
    %features_level4 = myHOG(im, [floor(y4/8) floor(x4/8)],[2 2],[1 1], 18, 1);
end
features = [features_level11,features_level12,features_level2,features_level3,features_level4];
ind11 = size(features_level11, 2);
ind12 = ind11 + size(features_level12, 2);
ind2 = ind12 + size(features_level2, 2);
ind3 = ind2 + size(features_level3, 2);
ind4 = ind3 + size(features_level4, 2);

end

