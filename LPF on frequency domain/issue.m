clc
clear

%% 导入原图像
img = imread("test_picture.tif");

%% 图像填充零
[w,h] = size(img);
PQ = [2*w 2*h];

%% 二维DFT变换
Freq_img = fft2(img,PQ(1),PQ(2));

%% 各类低通滤波器
ILPF = lpfilter('Ideal',PQ(1),PQ(2),2*20);          %理想低通滤波器
BTW = lpfilter('ButterWorth',PQ(1),PQ(2),2*20);      %巴特沃斯低通滤波器
Gaussian = lpfilter('Gaussian',PQ(1),PQ(2),2*20);   %高斯低通滤波器

%% 得到滤波后结果
ideal_img = real(ifft2(Freq_img.*ILPF));
ideal_img = ideal_img(1:size(img,1),1:size(img,2)); %经过理想低通滤波器处理后的图像
btw_img = real(ifft2(Freq_img.*BTW));
btw_img = btw_img(1:size(img,1),1:size(img,2));     %经过巴特沃斯低通滤波器处理后的图像
gaussian_img = real(ifft2(Freq_img.*Gaussian));
gaussian_img = gaussian_img(1:size(img,1),1:size(img,2));   %经过高斯低通滤波器处理后的图像

%% 图像展示
figure;imshow(img);title('导入原图');
figure;mesh(fftshift(ILPF));title('理想低通滤波器频域特性示意图');
figure;mesh(fftshift(BTW));title('三阶巴特沃斯低通滤波器频域特性示意图');
figure;mesh(fftshift(Gaussian));title('高斯低通滤波器频域特性示意图');

figure;imshow(uint8(ideal_img));title('经过理想低通滤波器处理后的图片');
figure;imshow(uint8(btw_img));title('经过三阶巴特沃斯低通滤波器处理后的图片');
figure;imshow(uint8(gaussian_img));title('经过高斯低通滤波器处理后的图片');

