function [im_resized] = resizeImage(im, tem_w, tem_h)
% [col, row] = size(im);
% position = findRect(im, tem_w, tem_h);

position = findRect(im); % 不用调用denoise了
x_original = position(1);
y_original = position(2);
w_original = position(3);
h_original = position(4);
% w_original = w;
% h_original = h;

if tem_w > tem_h
    if (tem_w/tem_h)>(w_original/h_original) && (w_original/h_original)>1
        w_resized = floor(h_original*tem_w / tem_h);
        h_resized = h_original;
        x_resized = floor((w_resized-w_original)/2)+1;
        y_resized = 1;
    elseif (tem_w/tem_h)<(w_original/h_original) && (w_original/h_original)>1
        h_resized = floor(w_original*tem_h / tem_w);
        w_resized = w_original;
        y_resized = floor((h_resized-h_original)/2)+1;
        x_resized = 1;
    else
        w_resized = floor(h_original*tem_w / tem_h);
        h_resized = h_original;
        x_resized = floor((w_resized-w_original)/2)+1;
        y_resized = 1;
    end
%     w_resized = floor(h_original*tem_w / tem_h);
% %     x = x - floor((w-t_w)/2);
%     x_resized = floor((w_resized-w_original)/2)+1;
%     h_resized = h_original;
else
    if (tem_w/tem_h)<(w_original/h_original) && (w_original/h_original)<1
        h_resized = floor(w_original*tem_h / tem_w);
        w_resized = w_original;
        y_resized = floor((h_resized-h_original)/2)+1;
        x_resized = 1;
    elseif (tem_w/tem_h)>(w_original/h_original) && (w_original/h_original)<1
        w_resized = floor(h_original*tem_w / tem_h);
        h_resized = h_original;
        x_resized = floor((w_resized-w_original)/2)+1;
        y_resized = 1;
    else
        h_resized = floor(w_original*tem_h / tem_w);
        w_resized = w_original;
        y_resized = floor((h_resized-h_original)/2)+1;
        x_resized = 1;
    end
%     h_resized = floor(w_original*tem_h / tem_w);
% %     y = y - floor((h-t_h)/2);
%     y_resized = floor((h_resized-h_original)/2)+1;
%     w_resized = w_original;
end

im2 = zeros(h_resized, w_resized); % 构造新的图片
im2 = 255 - im2;
im2 = im2uint8(im2);
im2(y_resized:y_resized+h_original-1, x_resized:x_resized+w_original-1) = ...
                                                im(y_original:y_original+h_original-1, x_original:x_original+w_original-1);
% if tem_w > tem_h
%     im2(1:1+h_original-1, x_resized:x_resized+w_original-1) = ...
%                                     im(y_original:y_original+h_original-1, x_original:x_original+w_original-1);
% else
%     im2(y_resized:y_resized+h_original-1, 1:1+w_original-1) = ...
%                                     im(y_original:y_original+h_original-1, x_original:x_original+w_original-1);
% end

% if position(2) < 0
%     im2(1-position(2):col-position(2),1:position(3)) = ...
%                                         im(1:col,position(1):position(1)+position(3)-1);
% elseif position(1) < 0
%     error('error');
% elseif position(1) == 0
%     error('error');
% elseif position(2) == 0
%     error('error');
% else
%   im2 = im(position(2):position(2)+position(4)-1, position(1):position(1)+position(3)-1);
% end

im_resized = im2;

end