clc
clear

% 导入测试图片
img = imread("666.tif");
img = rgb2gray(img);
% 二值化图像 选定阈值只留下数字部分
img = imbinarize(img,0.71);
% 展示原图
figure(1);imshow(img);title("原图像");

% 腐蚀的结构元素
kernel = [0,0,1,0,0;
          0,0,1,0,0;  
          1,1,1,1,1;
          0,0,1,0,0;
          0,0,1,0,0;];

% 进行若干次腐蚀操作
n = 10;     % 腐蚀次数
img_erode = img;
for i = 1:n
    img_erode = ImgErose(img_erode,kernel);
    figure(1+i);imshow(img_erode);title("腐蚀后的图像");
end

