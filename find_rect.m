function [position] = find_rect(I)
% I -- ����Ҷ�ͼ��, 0-��ɫ, 255-��ɫ
% position -- [x ,y, w, h], x,y-�������, w-���ο���, h-���θ߶�
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
w = xmax - xmin + 1;
h = ymax -ymin + 1;
tmp = h;
if h < w
    h = floor(w*447/430);
else
    w = floor(h*430/447);
end
y = y - floor((h-tmp + 1)/2);
position = [x y w h];