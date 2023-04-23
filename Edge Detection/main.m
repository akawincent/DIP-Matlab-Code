clc
clear

% 导入测试图像
img = imread("cloud.tif");
img = rgb2gray(img);

% 利用Sobel算子提取图像边缘
img_sharpen = SobelSharpen(img);

figure(1);imshow(img);title("原图像");
figure(2);imshow(img_sharpen);title("提取原图像的边缘");

% 绘制梯度方向(绘制过程需要等待一段时间)
hold on;
[dx, dy]=gradient(im2double(img));
quiver(dx,dy,4,'filled');



