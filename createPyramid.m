function [impy_level1, impy_level2, impy_level3, impy_level4] = createPyramid(origin_image)

impy_level4 = origin_image;
impy_level3 = impyramid(impy_level4, 'reduce');
impy_level2 = impyramid(impy_level3, 'reduce');
impy_level1 = impyramid(impy_level2, 'reduce');

end