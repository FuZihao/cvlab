[hog0, visualization0] = extractHOGFeatures(img_g1,'CellSize',[56 54],...
                                                'BlockSize',[2 2],...
                                                'BlockOverlap',[0 0],...
                                                'NumBins',18,...
                                                'UseSignedOrientation',true);
% figure(1);
% subplot(2,1,1);
% imshow(i03);
% subplot(2,2,2);
% plot(visualization0);
% bar(hog0);

[hog2, visualization2] = extractHOGFeatures(img_k1,'CellSize',[61 59],...
                                                'BlockSize',[2 2],...
                                                'BlockOverlap',[0 0],...
                                                'NumBins',18,...
                                                'UseSignedOrientation',true);
% figure(2);
% subplot(2,2,3);
% imshow(i23);
% subplot(2,2,4);
% plot(visualization2);
% bar(hog2);
% dis = pdist([hog0; hog2], 'cosine');
% 
% figure(1);
% subplot(2,1,1);
% imshow(img_g3);
% subplot(2,1,2);
% imshow(img_k3);
% 
% figure(2);
% for i = 0:1
%     subplot(1,2,i+1);
%     bar(hog0(i*18+1:i*18+18));
%     axis([0 19 0 0.3]);
% end
% 
% figure(3);
% for i = 0:1
%     subplot(1,2,i+1);
%     bar(hog2(i*18+1:i*18+18));
%     axis([0 19 0 0.3]);
% end
