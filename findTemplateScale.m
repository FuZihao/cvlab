function [ w, h ] = findTemplateScale( template_img )

[col,row] = size(template_img);
xmin = -1;
xmax = -1;
ymin = -1;
ymax = -1;

for j = 1 : row
   for i = 1 : col
       if (template_img(i,j) ~= 255)
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
       if (template_img(i,j) ~= 255)
           if (ymin == -1)
               ymin = i;
           end
           ymax = i;
           break;
       end
   end
end

w = xmax - xmin + 1;
h = ymax -ymin + 1;

end