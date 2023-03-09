clc
clear

%导入原图像原图像
img_pattern = imread("original_test_pattern.tif");

%展示测试用的原图像
figure;
imshow(img_pattern);
title("原图像");

%设计空间滤波器的核
w = 1/31*1/31*ones(31);

%进行线性平滑滤波操作
img_smooth_filter = imfilter(img_pattern,w,'conv','symmetric','same');

%平滑滤波后图像展示
figure;
imshow(img_smooth_filter);
title("经平滑滤波处理后的输出图像");


