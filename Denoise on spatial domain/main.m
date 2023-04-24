clc
clear

%% 导入测试图像
img = imread("robot.tif");
img = rgb2gray(img);

%% 向原图像引入高斯加性噪声
[w,h] = size(img);
img_gaussian = im2uint8(im2double(img) + imnoise2('gaussian',w,h,0,0.1)); 

%% 向原图像引入椒盐噪声
img_saltpepper = im2double(img);
R = imnoise2('salt & pepper',w,h);
for i = 1:w
    for j = 1:h
        if(R(i,j) == 0) 
            img_saltpepper(i,j) = 0;
        end
        if(R(i,j) == 1)
            img_saltpepper(i,j) = 1;
        end
    end
end
img_saltpepper = im2uint8(img_saltpepper);

%% 根据噪声类型不同选择不同的滤波策略
img_degassian = ImDenoise(im2double(img_gaussian),'average');
img_desaltpepper = ImDenoise(im2double(img_saltpepper),'medan');
img_degassian = im2uint8(img_degassian);
img_desaltpepper = im2uint8(img_desaltpepper);

% 经过观察可以发现中值滤波处理椒盐噪声的效果较好，然而均值滤波处理高斯噪声的效果差强人意
% 实际上空间域的均值滤波可以转化为频域的低通滤波器，尽管可以滤除掉高频段的噪声 
% 然而低频段的高斯噪声是无法和原图像信号区分开的 ，并且采用空间盒式滤波器也会模糊原图像
% 以上两点原因导致了空间均值滤波效果的不理想

% 解决方法：可以将图像建模成由高斯噪声驱动的全极点线性系统输出自回归模型，这样可以将
%          图像信号写成状态空间方程的形式，是一个线性高斯的系统。线性高斯系统的状态
%          估计问题(在有噪声图像基础上估计出一个最优的原图像)实际上是最小二乘法问题。
%          而卡尔曼滤波则给出了线性高斯系统下最优线性无偏估计。因此针对受高斯白噪声
%          污染图像，可以采用卡尔曼滤波器最优的恢复出原图像

figure(1);imshow(img);title("原图像");
figure(2);imshow(img_gaussian);title("受到高斯噪声污染的图像");
figure(3);imshow(img_saltpepper);title("受到椒盐噪声污染的图像");
figure(4);imshow(img_degassian);title("受高斯噪声污染的图像经过均值滤波处理后的输出图像");
figure(5);imshow(img_desaltpepper);title("受椒盐噪声污染的图像经过中值滤波处理后的输出图像");
