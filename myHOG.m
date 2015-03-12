function [ feature ] = myHOG( im, cellSize, blockSize, blockOverlap, numBins, signedDeg )
%MYHOG 计算图片梯度的强度和角度，提取HOG特征
%   im             输入图片
%   cellSize       HOG单元(cell)的大小，像素级粒度
%   blockSize      HOG块(block)中单元的数量
%   blockOverlap   相邻块之间重叠的单元数量
%   numBins        边缘直方图bin的数量
%   signedDeg      角度是否有符号

imBW = mat2gray(im); % 用作归一化
blockPerImage = floor((size(im) ./ cellSize - blockSize) ./ (blockSize - blockOverlap) + 1);
N = prod([blockPerImage, blockSize, numBins]);
if signedDeg
    binScale = 360/numBins;
else
    binScale = 180/numBins;
end

feature = zeros(1, N);
[ angle, magnitude ] = im2gradient( im );
% [ angle, magnitude ] = generateMat(); % for test

blocksInRow = blockPerImage(1);
blocksInCol = blockPerImage(2);
rowStride = (blockSize(1) - blockOverlap(1))*cellSize(1);
colStride = (blockSize(2) - blockOverlap(2))*cellSize(2);
blockpixel = [cellSize(1)*blockSize(1), cellSize(2)*blockSize(2)]; % block的大小，粒度为像素级
% Iterations for Blocks
for i = 1: blocksInRow
    for j= 1: blocksInCol
        mag_patch = magnitude( rowStride*(i-1)+1 : rowStride*(i-1)+blockpixel(1), colStride*(i-1)+1 : colStride*(i-1)+blockpixel(2) );
        ang_patch = angle( rowStride*(i-1)+1 : rowStride*(i-1)+blockpixel(1), colStride*(i-1)+1 : colStride*(i-1)+blockpixel(2) );
        
        blockLength = blockSize(1)*blockSize(2)*numBins;
        block_feature = zeros(1, blockLength);
        %Iterations for cells in a block
        for x= 1:blockSize(1)
            for y= 1:blockSize(2)
                angleA =ang_patch( cellSize(1)*(x-1)+1 : cellSize(1)*(x-1)+cellSize(1), cellSize(2)*(y-1)+1 : cellSize(2)*(y-1)+cellSize(2) );
                magA   =mag_patch( cellSize(1)*(x-1)+1 : cellSize(1)*(x-1)+cellSize(1), cellSize(2)*(y-1)+1 : cellSize(2)*(y-1)+cellSize(2) );
                histr  =zeros(1,numBins);
                %Iterations for pixels in one cell
                normalizor = 0;
                for p=1:cellSize(1)
                    for q=1:cellSize(2)
                        normalizor = normalizor + imBW(p,q);
                        alpha= angleA(p,q);
                        binNum = floor(alpha/binScale);
                        first = binNum+1; % histr的下标从1开始
                        next = mod(binNum+2, numBins);
                        % Binning Process (Linear Interpolation)
                        histr(first) = histr(first) + magA(p,q)*( (binNum+1)*binScale - alpha );
                        histr(next) = histr(next) + magA(p,q)*( alpha - (binNum)*binScale );
                    end
                end
                histr = histr ./ normalizor;
                block_feature(numBins*(x*y-1)+1 : numBins*(x*y-1)+numBins) = histr;
            end
        end
        % Normalize the values in the block using L1-Norm
        block_feature = block_feature/sqrt(norm(block_feature)^2+.01);
        feature(blockLength*(i*j-1)+1 : blockLength*(i*j-1)+blockLength) = block_feature;
    end
end
feature(isnan(feature))=0; %Removing Infinitiy values
% Normalization of the feature vector using L2-Norm
feature=feature/sqrt(norm(feature)^2+.001);
for z=1:length(feature)
    if feature(z)>0.2
         feature(z)=0.2;
    end
end
feature=feature/sqrt(norm(feature)^2+.001);   
end

