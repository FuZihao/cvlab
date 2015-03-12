function [ angle, magnitude ] = generateMat(  )
%GENERATEMAT 生成角度和强度矩阵，用来测试
%   angle     角度矩阵
%   magnitude 强度矩阵

angle = repmat([15,0;15,15], 3, 3);
magnitude = repmat([1,0;1,1], 3, 3);

end

