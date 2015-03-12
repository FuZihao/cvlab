function [position] = findRect(I)

[col,row] = size(I); % [y,x] = size(I)
xmin = -1;
xmax = -1;
ymin = -1;
ymax = -1;

for j = 1 : row
   for i = 1 : col
%        if (I(i,j) ~= 255)
        if I(i,j) < 180
           if (xmin == -1)
               xmin = j;
           end
           xmax = j;
           break;
       end
   end
end

for i = 1 : col
   for j = 1 : row
%        if (I(i,j) ~= 255)
        if I(i,j) < 180
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
h = ymax - ymin + 1;
position = [x y w h];

end