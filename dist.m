function [ dis ] = dist( hog1, hog2 )
%DIST Summary of this function goes here
%   Detailed explanation goes here
dis = 0;
dis = dis + 1/2 * pdist([hog1(1:72); hog2(1:72)],'cosine') + ...
                1/4 * pdist([hog1(73:144); hog2(73:144)], 'cosine') + ...
                1/16 * pdist([hog1(145:432); hog2(145:432)]) + ...
                1/64 * pdist([hog1(433:1584); hog2(433:1584)]);

end

