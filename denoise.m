function [ im1 ] = denoise( im )
%DENOISE Summary of this function goes here
%   Detailed explanation goes here

[col, row] = size(im);
im1 = im;
for i = 1:col
    for j = 1:row
        if im(i,j) > 200
            im1(i,j) = 255;
        end
    end
end

end
