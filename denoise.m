function [ im1 ] = denoise( im )
%DENOISE Summary of this function goes here
%   Detailed explanation goes here

[cols, rows] = size(im);
% label = zeros(cols, rows);
im1 = im;
for i = 1:cols
    for j = 1:rows
        if im(i,j) > 240
%             label(i,j) = 1;
           im1(i,j) = 255;
%         else
%             im1(i,j) = 0;
        end
    end
end

% label = int8(label);
% im1 = im .* label;

end

