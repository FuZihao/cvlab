function drawRect(im)
[im_py_l1, im_py_l2, im_py_l3, im_py_l4] = createPyramid(im);

% draw rectangle of level 1
figure;
subplot(1,2,1);
imshow(im_py_l1);
hold on;
[YY,XX] = size(im_py_l1);
inc_x = floor(XX/2);
inc_y = floor(YY/2);

for ii = 0:inc_x:XX-inc_x
    position = [ii 0 inc_x YY];
    rectangle('Position', position, 'LineWidth',1,'EdgeColor','r');
end
subplot(1,2,2);
imshow(im_py_l1);
hold on;
for jj = 0:inc_y:YY-inc_y
    position = [0 jj XX inc_y];
    rectangle('Position', position, 'LineWidth',1, 'EdgeColor', 'r');
end

% draw rectangle of level 2
figure;
imshow(im_py_l2);
[YY,XX] = size(im_py_l2);
inc_x = floor(XX/2);
inc_y = floor(YY/2);
for ii = 0:inc_x:XX
    for jj = 0:inc_y:YY-inc_y
        position = [ii jj inc_x YY];
        rectangle('Position', position, 'LineWidth',1,'EdgeColor','r');
    end
end

% draw rectangle of level3
figure;
imshow(im_py_l3);
[YY,XX] = size(im_py_l3);
inc_x = floor(XX/4);
inc_y = floor(YY/4);
for ii = 0:inc_x:XX
    for jj = 0:inc_y:YY-inc_y
        position = [ii jj inc_x YY];
        rectangle('Position', position, 'LineWidth',1,'EdgeColor','r');
    end
end

% draw rectangle of level4
figure;
imshow(im_py_l4);
[YY,XX] = size(im_py_l4);
inc_x = floor(XX/8);
inc_y = floor(YY/8);
for ii = 0:inc_x:XX
    for jj = 0:inc_y:YY-inc_y
        position = [ii jj inc_x YY];
        rectangle('Position', position, 'LineWidth',1,'EdgeColor','r');
    end
end

end