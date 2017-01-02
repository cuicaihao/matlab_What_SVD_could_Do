% Using SVD method to compress images
% Load the Lenna image and turn rgb image into gray image.
clc;clear; 
%lenna = imread('lenna_original_1972.jpg');
lenna = imread('lenna.png');
lenna = rgb2gray(lenna);

figure(1); clf;
subplot(1,3,1);
imshow(lenna);
title('Original Image');
xlabel(ByteSize(lenna));

% Using the SVD method to compress the images
[U,S,V] = svd(double(lenna));
singularValue = diag(S);
Rate = cumsum(singularValue)/sum(singularValue);
subplot(1,3,2)

Pos = 512 ;

plot(Rate,'r.');hold on;grid on;
line([Pos Pos], [0 Rate(Pos)], 'linewidth',2,'Marker','o');
%line([180,0],[180,Rate(180)],'r', 'Marker', 'o'); hold off;
txt1 = strcat('\leftarrow   ',num2str(Rate(Pos)));
text(Pos,Rate(Pos),txt1);

% Using the first Pos singular value and vectors to reconstruct the image
lenna_R = U(:,1:Pos)*S(1:Pos,1:Pos)*V(:,1:Pos)';
lenna_R = mat2gray(lenna_R);
lenna_R = uint8(255 * mat2gray(lenna_R));
subplot(1,3,3);
imshow(lenna_R);
title(strcat('Reconstructed Image :', num2str(Rate(Pos)*100),'%'));

xlabel(ByteSize(lenna_R));
ElementNum = size(U,1)*Pos + Pos + size(V,1)*Pos;
xlabel(ByteSize(uint8(255 * mat2gray(rand(1,ElementNum)))));


