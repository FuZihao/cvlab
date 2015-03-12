function [ angle, magnitude ] = im2gradient( im )
%IM2GRADIENT 计算图片im各像素的梯度和强度
%   im           图片
%   angle        梯度角度矩阵
%   magnitude    梯度强度矩阵

% Convert RGB iamge to grayscale
if size(im,3)==3
    im=rgb2gray(im);
end
im=double(im);
rows=size(im,1);
cols=size(im,2);

% temp= zeros(cols+2, rows+2);
temp= zeros(rows+2, cols+2);
temp = 255 - temp;
temp(2:1+rows,2:1+cols)=im(:,:);
im = temp;
% im = mat2gray(im);
% Ix = im; %Basic Matrix assignment
% Iy = im; %Basic Matrix assignment
% Ix = ones(rows, cols);
% Iy = ones(rows, cols);
% Gradients in X and Y direction. Iy is the gradient in X direction and Ix
% is the gradient in Y direction

filter = 1; % default value is 1, sobel is 0;
% computing the gradients using [-1,0,1]
if filter
%     for i=1:rows
%         Ix(i,:)=im(i,:)-im(i+2,:);
%     end
%     for i=1:cols
%         Iy(:,i)=im(:,i)-im(:,i+2);
%     end
%     angle=atand(Iy./Ix); % Matrix containing the angles of each edge gradient
%     angle=imadd(angle,90); % Angles in range (0,180)
%     magnitude=sqrt(Ix.^2 + Iy.^2);
    centricx = [-1; 0; 1];
    centricy = centricx';
    filterx = centricx;
    filtery = centricy;
else
%     maskx = zeros(cols+2, rows+2);
%     masky = zeros(cols+2, rows+2);
%     maskx(2:1+cols, 2:1+rows) = Ix(:,:);
%     masky(2:1+cols, 2:1+rows) = Iy(:,:);

    % computing the gradients using sobel
    sobelx = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
    sobely = sobelx';
%     fx = filter2(sobelx, im);
%     fy = filter2(sobely, im);
%     Ix = fx(2:1+rows, 2:1+cols);
%     Iy = fy(2:1+rows, 2:1+cols);
    filterx = sobelx;
    filtery = sobely;
end
fx = filter2(filterx, im);
fy = filter2(filtery, im);
Ix = fx(2:1+rows, 2:1+cols);
Iy = fy(2:1+rows, 2:1+cols);

angle = rad2deg(atan2(Iy, Ix));
index = angle(:) < 0;
sign = 0; % 1 using signed angle, 0 using unsigned angle
if sign
%     angle = imadd(angle, 360); % Angles in range (0,360)
    angle(index) = angle(index) + 360;
else
    angle(index) = angle(index) + 180;
%     unsigned_ang(signed_ang(:)<0)=signed_ang(signed_ang(:)<0)+180
%     angle = imadd((angle(:)<0), 180); % Angles in range (0,180)
end

magnitude=sqrt(Ix.^2 + Iy.^2);

% Remove redundant pixels in an image. 
angle(isnan(angle))=0;
magnitude(isnan(magnitude))=0;

end
