function [ feature ] = extractFeature( templateHis, matchingHis, ind1, ind2, ind3, ind4, ind5 )
%EXTRACTFEATURE 根据templateImage，提取matchingImage的特征
%   templateImage   模板图片
%   matchingImage   匹配图片
%   feature         输出的特征
% 
% dis1 = dist2(templateHis(1:72), matchingHis(1:72));
% dis2 = dist2(templateHis(73:144), matchingHis(73:144));
% dis3 = dist2(templateHis(145:432), matchingHis(145:432));
% dis4 = dist2(templateHis(433:1584), matchingHis(433:1584));

dis1 = dist2(templateHis(1:ind1), matchingHis(1:ind1));
dis2 = dist2(templateHis(ind1+1:ind2), matchingHis(ind1+1:ind2));
dis3 = dist2(templateHis(ind2+1:ind3), matchingHis(ind2+1:ind3));
dis4 = dist2(templateHis(ind3+1:ind4), matchingHis(ind3+1:ind4));
dis5 = dist2(templateHis(ind4+1:ind5), matchingHis(ind4+1:ind5));
feature = [dis1,dis2,dis3,dis4,dis5];
end

