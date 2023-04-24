clc
clear;

% 导入测试图片
img_rc = imread("rc.tif");
img_tower = imread("tower.tif");
img_rc = rgb2gray(img_rc);
img_tower = rgb2gray(img_tower);

% 展示遥控器原图像及其直方图
% 通过观察直方图可以发现 遥控器的直方图具有明显的双峰特征
figure(1);imshow(img_rc);title("遥控器原图像");
figure(2);imhist(img_rc);title("遥控器原图像直方图")

% 基于双峰直方图谷底最小值灰度阈值做全局二值化处理
img_segement = HistImgSegement(img_rc);
img_segement = uint8(img_segement);

% 展示遥控器图二值化图像
% 效果较好 甚至能将遥控器上的丝印标注成功分割
figure(4);imshow(img_segement);title("经过图像分割后的遥控器图二值化图像");

% 展示广州塔原图像及其直方图
% 通过观察直方图可以发现 广州塔的直方图没有明显的双峰特征
% 在低灰度值处具有单峰特征 在高灰度值灰度分布更加平坦
figure(5);imshow(img_tower);title("广州塔原图像");
figure(6);imhist(img_tower);title("广州塔原图像直方图")

% 基于Otsu大津算法使前景和背景两类的类间方差最大来选取灰度阈值做二值化处理、
% 对于具有平坦直方图的图像有一定适应能力
img_otsu = OtsuImgSegement(img_tower);
img_otsu = uint8(img_otsu);

% 展示广州塔二值化图像
% 效果较好 黑色及阴影除外的物体均成功分割  甚至可以将水面的反光给分割出来
figure(7);imshow(img_otsu);title("经过图像分割后的广州塔二值化图像");




