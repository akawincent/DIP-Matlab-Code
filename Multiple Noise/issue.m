clc
clear

%% 导入原图并加入六种噪声
img_test = imread("test_picture.tif");
figure;imshow(img_test);title("原图");
img_double = im2double(img_test);
[w,h] = size(img_test);

img_gaussian = im2uint8(img_double + imnoise2('gaussian',w,h,0.1,0.08)); 
img_rayleigh = im2uint8(img_double + imnoise2('rayleigh',w,h,0.0001,0.025));
img_erlang = im2uint8(img_double + imnoise2('erlang',w,h,25,2));
img_exponential = im2uint8(img_double + imnoise2('exponential',w,h,10));
img_uniform = im2uint8(img_double + imnoise2('uniform',w,h,0,0.25));

R = imnoise2('salt & pepper',w,h);
for i = 1:w
    for j = 1:h
        if(R(i,j) == 0) 
            img_double(i,j) = 0;
        end
        if(R(i,j) == 1)
            img_double(i,j) = 1;
        end
    end
end
img_saltpepper = im2uint8(img_double);

%% 受噪声污染图像及直方图展示
figure;
subplot(231);imshow(img_gaussian);title("受高斯噪声污染的图像");
subplot(232);imshow(img_rayleigh);title("受瑞利噪声污染的图像");
subplot(233);imshow(img_erlang);title("受爱尔兰噪声污染的图像");
subplot(234);imshow(img_exponential);title("受指数噪声污染的图像");
subplot(235);imshow(img_uniform);title("受均匀噪声污染的图像");
subplot(236);imshow(img_saltpepper);title("受椒盐噪声污染的图像");

figure;
subplot(231);
imhist(img_gaussian);
axis([0,255,0,700])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:50:700)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("受高斯噪声污染图像的灰度直方图")

subplot(232);
imhist(img_rayleigh);
axis([0,255,0,750])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:50:750)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("受瑞利噪声污染图像的灰度直方图")

subplot(233);
imhist(img_erlang);
axis([0,255,0,1300])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:100:1300)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("受爱尔兰噪声污染图像的灰度直方图")

subplot(234);
imhist(img_exponential);
axis([0,255,0,1300])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:100:1300)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("受指数噪声污染图像的灰度直方图")

subplot(235);
imhist(img_uniform);
axis([0,255,0,1300])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:100:1300)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("受均匀噪声污染图像的灰度直方图")

subplot(236);
imhist(img_saltpepper);
axis([0,255,0,35000])
set(gca,'xtick',0:20:255)
set(gca,'ytick',0:5000:35000)
xlabel("灰度级")
ylabel("相应灰度级出现次数")
title("受均匀噪声污染图像的灰度直方图")