clc;
clear;

%创建图像矩阵
img_1 = zeros(400);     %稀疏黑白相间竖条纹
img_2 = zeros(400);     %密集黑白相间竖条纹
img_3 = zeros(400);     %稀疏黑白相间横条纹
img_4 = zeros(400);     %密集黑白相间横条纹
img_5 = zeros(400);     %稀疏黑白相间斜条纹     
img_6 = zeros(400);     %密集黑白相间斜条纹

%生成稀疏黑白相间竖条纹
color_mode = 0;
for i = 1:40:400
    if(color_mode == 0)
        img_1(i:i+39,:) = 255;
        color_mode = 1;
    else
        img_1(i:i+39,:) = 0;
        color_mode = 0; 
    end
end

%生成密集黑白相间竖条纹
color_mode = 0;
for i = 1:20:400
    if(color_mode == 0)
        img_2(i:i+19,:) = 255;
        color_mode = 1;
    else
        img_2(i:i+19,:) = 0;
        color_mode = 0; 
    end
end

%生成稀疏黑白相间横条纹
color_mode = 0;
for j = 1:40:400
    if(color_mode == 0)
        img_3(:,j:j+39) = 255;
        color_mode = 1;
    else
        img_3(:,j:j+39) = 0;
        color_mode = 0; 
    end
end

%生成密集黑白相间横条纹
color_mode = 0;
for j = 1:20:400
    if(color_mode == 0)
        img_4(:,j:j+19) = 255;
        color_mode = 1;
    else
        img_4(:,j:j+19) = 0;
        color_mode = 0; 
    end
end

%生成稀疏黑白相间斜条纹
for sum = [40:120,200:280,360:400]
    for i = 1:400
        for j = 1:400
            if(i+j == sum)
                img_5(i,j) = 255;
                img_5(400-i,400-j) = 255;
            end
        end
    end
end

%生成密集黑白相间斜条纹
for sum = [0:20,60:100,140:180,220:260,300:340,380:400]
    for i = 1:400
        for j = 1:400
            if(i+j == sum)
                img_6(i,j) = 255;
                img_6(400-i,400-j) = 255;
            end
        end
    end
end

%对稀疏黑白相间竖条纹进行500次高斯平滑滤波
img_1_filter = Gaussian_filter(img_1,500);
%对密集黑白相间竖条纹进行200次高斯平滑滤波
img_2_filter = Gaussian_filter(img_2,200);
%对稀疏黑白相间横条纹进行500次高斯平滑滤波
img_3_filter = Gaussian_filter(img_3,500);
%对密集黑白相间横条纹进行200次高斯平滑滤波
img_4_filter = Gaussian_filter(img_4,200);
%对稀疏黑白相间斜条纹进行500次高斯平滑滤波
img_5_filter = Gaussian_filter(img_5,500);
%对密集黑白相间斜条纹进行200次高斯平滑滤波
img_6_filter = Gaussian_filter(img_6,200);

%二维傅里叶变换
freq_img_1 = fftshift(fft2(img_1));
freq_img_2 = fftshift(fft2(img_2));
freq_img_3 = fftshift(fft2(img_3));
freq_img_4 = fftshift(fft2(img_4));
freq_img_5 = fftshift(fft2(img_5));
freq_img_6 = fftshift(fft2(img_6));

freq_img_1_filter = fftshift(fft2(img_1_filter));
freq_img_2_filter = fftshift(fft2(img_2_filter));
freq_img_3_filter = fftshift(fft2(img_3_filter));
freq_img_4_filter = fftshift(fft2(img_4_filter));
freq_img_5_filter = fftshift(fft2(img_5_filter));
freq_img_6_filter = fftshift(fft2(img_6_filter));

%对数灰度变换增强视觉效果
Amp_freq_1 = log(1 + abs(freq_img_1));
Amp_freq_2 = log(1 + abs(freq_img_2));
Amp_freq_3 = log(1 + abs(freq_img_3));
Amp_freq_4 = log(1 + abs(freq_img_4));
Amp_freq_5 = log(1 + abs(freq_img_5));
Amp_freq_6 = log(1 + abs(freq_img_6));

Amp_freq_1_filter = log(1 + abs(freq_img_1_filter));
Amp_freq_2_filter = log(1 + abs(freq_img_2_filter));
Amp_freq_3_filter = log(1 + abs(freq_img_3_filter));
Amp_freq_4_filter = log(1 + abs(freq_img_4_filter));
Amp_freq_5_filter = log(1 + abs(freq_img_5_filter));
Amp_freq_6_filter = log(1 + abs(freq_img_6_filter));

figure;
subplot(2,3,1);imshow(img_1);title("生成的稀疏黑白相间竖条纹");
subplot(2,3,2);imshow(img_2);title("生成的密集黑白相间竖条纹");
subplot(2,3,3);imshow(img_3);title("生成的稀疏黑白相间横条纹");
subplot(2,3,4);imshow(img_4);title("生成的密集黑白相间横条纹");
subplot(2,3,5);imshow(img_5);title("生成的稀疏黑白相间斜条纹");
subplot(2,3,6);imshow(img_6);title("生成的密集黑白相间斜条纹");

figure;
subplot(2,3,1);imshow(uint8(img_1_filter));title("边缘模糊的稀疏黑白相间竖条纹");
subplot(2,3,2);imshow(uint8(img_2_filter));title("边缘模糊的密集黑白相间竖条纹");
subplot(2,3,3);imshow(uint8(img_3_filter));title("边缘模糊的稀疏黑白相间横条纹");
subplot(2,3,4);imshow(uint8(img_4_filter));title("边缘模糊的密集黑白相间横条纹");
subplot(2,3,5);imshow(uint8(img_5_filter));title("边缘模糊的稀疏黑白相间斜条纹");
subplot(2,3,6);imshow(uint8(img_6_filter));title("边缘模糊的密集黑白相间斜条纹");


figure;imshow(Amp_freq_1,[]);title("稀疏黑白相间竖条纹频域幅度值");
figure;imshow(Amp_freq_2,[]);title("密集黑白相间竖条纹频域幅度值");
figure;imshow(Amp_freq_3,[]);title("稀疏黑白相间横条纹频域幅度值");
figure;imshow(Amp_freq_4,[]);title("密集黑白相间横条纹频域幅度值");
figure;imshow(Amp_freq_5,[]);title("稀疏黑白相间斜条纹频域幅度值");
figure;imshow(Amp_freq_6,[]);title("密集黑白相间斜条纹频域幅度值");


figure;imshow(Amp_freq_1_filter,[]);title("边缘模糊的稀疏黑白相间竖条纹频域幅度值");
figure;imshow(Amp_freq_2_filter,[]);title("边缘模糊的密集黑白相间竖条纹频域幅度值");
figure;imshow(Amp_freq_3_filter,[]);title("边缘模糊的稀疏黑白相间横条纹频域幅度值");
figure;imshow(Amp_freq_4_filter,[]);title("边缘模糊的密集黑白相间横条纹频域幅度值");
figure;imshow(Amp_freq_5_filter,[]);title("边缘模糊的稀疏黑白相间斜条纹频域幅度值");
figure;imshow(Amp_freq_6_filter,[]);title("边缘模糊的密集黑白相间斜条纹频域幅度值");



