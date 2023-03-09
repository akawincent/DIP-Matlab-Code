clc
clear

%导入原图像
img_moon = imread("moon.tif");

%展示测试用的原图像
figure;
imshow(img_moon);
title("原图像");

%设计基于拉普拉斯算子的滤波器核子
w = fspecial('laplacian',0);

%进行锐化滤波操作
img_moon_double = im2double(img_moon);
img_sharpen_filter = imfilter(img_moon_double,w,'conv','symmetric','same');

%展示锐化后的图像（包含负值）
figure;
imshow(img_sharpen_filter);
title("锐化滤波后的输出图像");

%图像增强操作
c = 1;
img_enhance = img_moon_double - c*img_sharpen_filter;

%展示经过图像增强处理后的输出图像
figure;
imshow(img_enhance);
title("经过图像增强后的输出图像");
