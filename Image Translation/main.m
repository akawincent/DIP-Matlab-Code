clc
clear

% 导入测试图像(RGB三通道图像)
img = imread("seagull.tif");

% 分别提取三通道的灰度矩阵
img_R = img(:,:,1);
img_G = img(:,:,2);
img_B = img(:,:,3);

% 设置平移量
Tx = 100;       % 移动的行数
Ty = 200;       % 移动的列数

% 计算得到三通道经过平移变换后的矩阵
img_R_transed = ImgMove(img_R,Tx,Ty);
img_G_transed = ImgMove(img_G,Tx,Ty);
img_B_transed = ImgMove(img_B,Tx,Ty);

% 创建最终输出的RGB图像矩阵
img_RGB_trans = img;
img_RGB_trans(:,:,1) = img_R_transed;
img_RGB_trans(:,:,2) = img_G_transed;
img_RGB_trans(:,:,3) = img_B_transed;


figure(1);imshow(img);title("原图像");
figure(2);imshow(img_RGB_trans);title("经过平移变换后的图像");