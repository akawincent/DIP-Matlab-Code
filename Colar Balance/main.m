clc
clear

% 导入测试图像
img = imread("landscape.tif");
% 观察原图像 可以发现粉红色成分占了主导因素
% 因此可以通过降低红色和黄色的比例或增大蓝色比例来实现
figure(1);imshow(img);title("原图像");

% 色彩平衡 采用灰度世界法
img_correct = Colorbalance(img);
% 经过色彩平衡校正后的图像 占主导的主色调粉红色分量减少 色彩更加平衡
% 个人认为经过矫正后的图像不是那么有美感了
figure(2);imshow(img_correct);title("色彩校正后的图像");


