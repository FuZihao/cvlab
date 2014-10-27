t = imread('./data/diving/diving-template.jpg');
t = rgb2gray(t);
t_res = resize_image(t);
hog = hier_hog(t_res);


% imshow(t_res);
% 
% t_res3 = impyramid(t_res, 'reduce');
% t_res2 = impyramid(t_res3, 'reduce');
% t_res1 = impyramid(t_res2, 'reduce');
% 
% imshow(t_res1);
% [y1,x1] = size(t_res1);
% [features,vil1]= extractHOGFeatures(t_res1,'CellSize',[y1 floor(x1/2)],...
%                                                 'BlockSize',[1 2],...
%                                                 'BlockOverlap',[0 0],...
%                                                 'NumBins',18,...
%                                                 'UseSignedOrientation',true);
% plot(vil1);