clc
clear

%导入月球灰度图
img_moon = imread("moon.tif");

%展示原图
figure;
imshow(img_moon)
title("导入原图")

%直方图处理
hist_moon = imhist(img_moon);
hist_v = hist_moon(1:5:256);
horz = 1:5:256;

%利用imhist画出直方图
figure;
subplot(2,2,1)
imhist(img_moon)
axis([0,255,0,450000])
set(gca,'xtick',0:10:255)
set(gca,'ytick',0:50000:450000)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("利用imhist绘制的灰度直方图")

%利用bar画出直方图
subplot(2,2,2);
bar(horz,hist_v);
axis([0,255,0,450000])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:50000:450000)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("利用bar绘制的灰度直方图")

%利用stem画出直方图
subplot(2,2,3);
stem(horz,hist_v,'fill');
axis([0,255,0,450000])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:50000:450000)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("利用stem绘制的灰度直方图")

%利用plot画出直方图
subplot(2,2,4);
plot(hist_moon);
axis([0,255,0,450000])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:50000:450000)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("利用plot绘制的灰度直方图")


