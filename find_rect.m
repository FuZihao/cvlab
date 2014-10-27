function [position] = find_rect(I)
% I -- 输入灰度图像, 0-黑色, 255-白色
% position -- [x ,y, w, h], x,y-起点坐标, w-矩形宽度, h-矩形高度
[col,row] = size(I);
xmin = -1;
xmax = -1;
ymin = -1;
ymax = -1;

for j = 1 : row
   for i = 1 : col
       if (I(i,j) ~= 255)
           if (xmin == -1)
               xmin = j;
               disp('found');
           end
           xmax = j;
           break;
       end
   end
end

for i = 1 : col
   for j = 1 : row
       if (I(i,j) ~= 255)
           if (ymin == -1)
               ymin = i;
           end
           ymax = i;
           break;
       end
   end
end

x = xmin;
y = ymin;
w = xmax - xmin;
h = ymax -ymin;
position = [x y w h];