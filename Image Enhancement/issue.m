clc
clear

%% 导入图像并进行填充
img_test = imread("x_ray.tif");
[w,h] = size(img_test);
PQ = [2*w 2*h];

%% 二维DFT变换
Freq_img = fft2(img_test,PQ(1),PQ(2));

%% 构建高频强调滤波器核
R = 0.05 * PQ(1);                                     %滤波器核半径 5%的占比
low_pass = lpfilter('ButterWorth',PQ(1),PQ(2),R,2);   %二阶巴特沃斯低通滤波器
high_pass = 1 - low_pass;                             %二阶巴特沃斯高通滤波器
H = 0.5 + 2 * high_pass;                              %高频强调滤波器核

%% 得到高频强调滤波后结果
img_hfef = real(ifft2(Freq_img.*H));
img_hfef = img_hfef(1:size(img_test,1),1:size(img_test,2));

%% 直方图均衡化
img_hist = histeq(uint8(img_hfef),256);

%% 结果展示
figure;
imshow(img_test);title("导入的原图");
figure;
imshow(uint8(img_hfef));title("经过高通滤波器锐化后的图像");
figure;
imshow(img_hist);title("经过直方图均衡化处理后的图像")
