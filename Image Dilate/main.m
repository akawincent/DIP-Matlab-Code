clc
clear

% 导入测试图片
img = imread("666_eroded.tif");
img = rgb2gray(img);
% 二值化图像 选定阈值只留下字体部分
img = imbinarize(img,0.55);
% 展示原图
figure(1);imshow(img);title("原图像");

% 膨胀的结构元素
kernel = [0,0,1,0,0;
          0,0,1,0,0;  
          1,1,1,1,1;
          0,0,1,0,0;
          0,0,1,0,0;];

% 进行若干次腐蚀操作
n = 15;     % 膨胀次数
img_dilate = img;
for i = 1:n
    img_dilate = ImgDilate(img_dilate,kernel);
    figure(1+i);imshow(img_dilate);title("膨胀后的图像");
end

% 对被执行了腐蚀操作的图片再执行膨胀操作，并不能使其恢复原样