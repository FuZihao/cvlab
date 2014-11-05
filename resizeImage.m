function [im_resized] = resizeImage(im, tem_w, tem_h)
[col, row] = size(im);
position = findRect(im, tem_w, tem_h);
im2 = zeros(position(4),position(3));
im2 = 255 - im2;

if position(2) < 0
    im2(1-position(2):col-position(2),1:position(3)) = ...
                                        im(1:col,position(1):position(1)+position(3)-1);
elseif position(1) < 0
    error('error');
else
  im2 = im(position(2):position(2)+position(4)-1, position(1):position(1)+position(3)-1);  
end
im_resized = im2;
end