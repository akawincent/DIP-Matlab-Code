clc
clear

%导入花粉灰度图
img_pollen = imread("pollen.tif");

%展示原图
figure;
imshow(img_pollen)
title("导入原图")

%直方图处理
hist_pollen = imhist(img_pollen);
hist_v = hist_pollen(1:5:256);
horz = 1:5:256;

%利用imhist画出直方图
figure;
subplot(2,2,1)
imhist(img_pollen)
axis([0,255,0,20000])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:2000:20000)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("利用imhist绘制的灰度直方图")

%利用bar画出直方图
subplot(2,2,2);
bar(horz,hist_v);
axis([0,255,0,12000])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:2000:12000)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("利用bar绘制的灰度直方图")

%利用stem画出直方图
subplot(2,2,3);
stem(horz,hist_v,'fill');
axis([0,255,0,12000])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:2000:12000)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("利用stem绘制的灰度直方图")

%利用plot画出直方图
subplot(2,2,4);
plot(hist_pollen);
axis([0,255,0,20000])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:2000:20000)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("利用plot绘制的灰度直方图")