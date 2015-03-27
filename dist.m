function [ dis ] = dist( hog1, hog2, ind1, ind2, ind3, ind4, ind5 )
%DIST Summary of this function goes here
%   Detailed explanation goes here
dis = 0;
% dis1 = pdist([hog1(1:72); hog2(1:72)],'cosine');
% dis2 = pdist([hog1(73:144); hog2(73:144)], 'cosine');
% dis3 = pdist([hog1(145:432); hog2(145:432)], 'cosine');
% dis4 = pdist([hog1(433:1584); hog2(433:1584)], 'cosine');

% dis = dis + 1/2 * pdist([hog1(1:72); hog2(1:72)],'cosine') + ...
%                 1/4 * pdist([hog1(73:144); hog2(73:144)], 'cosine') + ...
%                 1/16 * pdist([hog1(145:432); hog2(145:432)]) + ...
%                 1/64 * pdist([hog1(433:1584); hog2(433:1584)]);

dis1 = pdist([hog1(1:ind1); hog2(1:ind1)],'cosine');
dis2 = pdist([hog1(ind1+1:ind2); hog2(ind1+1:ind2)], 'cosine');
dis3 = pdist([hog1(ind2+1:ind3); hog2(ind2+1:ind3)], 'cosine');
dis4 = pdist([hog1(ind3+1:ind4); hog2(ind3+1:ind4)], 'cosine');
dis5 = pdist([hog1(ind4+1:ind5); hog2(ind4+1:ind5)], 'cosine');
dis = dis + 1/2 * dis1 + 1/2 * dis2 + 1/4 * dis3 + 1/16 * dis4 + 1/64 * dis5;
end

