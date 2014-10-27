function [im_resized] = resize_image(im)

position = find_rect(im);
im_resized = im(position(2):position(2)+position(4)-1, position(1):position(1)+position(3)-1);
% imshow(img);

% position_k = find_rect(kk);
% img_k = kk(position_k(2):position_k(2)+position_k(4)-1, position_k(1):position_k(1)+position_k(3));
end