clc
clear

%% 导入原图并进行镜像填充
img_test = imread("test_picture.tif");
figure;imshow(img_test);title("原图");

[w,h] = size(img_test);
img_pad = zeros(w+4,h+4);
img_pad(3:258,3:258) = img_test;
img_pad = im2uint8(img_pad);

%% 5*5的谐波平均滤波器
[rows,cols] = size(img_pad);
img_harmonic = zeros(rows,cols);
sum = 0;
for i = 3:rows-2
    for j = 3:cols-2
        for m = 1:5
            for n =1:5
                sum = sum + 1/img_pad(i-3+m,j-3+n);
            end
        end
        img_harmonic(i,j) = 5*5/sum;
        sum = 0;
    end
end
img_harmonic = img_harmonic(3:256,3:256);
figure;imshow(img_harmonic);title("经过5*5谐波平均滤波器处理后的图像");

%% 5*5 Q=-1的反谐波平均滤波器
[rows,cols] = size(img_pad);
img_contra_harmonic = zeros(rows,cols);
sum_1 = 0;
sum_2 = 0;
Q = -1;
for i = 3:rows-2
    for j = 3:cols-2
        for m = 1:5
            for n =1:5
                sum_1 = sum_1 + (img_pad(i-3+m,j-3+n)).^(Q+1);
                sum_2 = sum_2 + 1/(img_pad(i-3+m,j-3+n));
            end
        end
        img_contra_harmonic(i,j) = sum_1/sum_2;
        sum_1 = 0;
        sum_2 = 0;
    end
end
img_contra_harmonic = img_contra_harmonic(3:256,3:256);
figure;imshow(img_contra_harmonic);title("经过5*5 Q=-1反谐波平均滤波器处理后的图像");

%% 5*5最大值滤波器
[rows,cols] = size(img_pad);
img_max= zeros(rows,cols);
max = -9999;
for i = 3:rows-2
    for j = 3:cols-2
        for m = 1:5
            for n =1:5
                if(img_pad(i-3+m,j-3+n)>max)
                    max = img_pad(i-3+m,j-3+n);
                end
            end
        end
        img_max(i,j) = max;
        max = -9999;
    end
end
img_max = img_max(3:256,3:256);
figure;imshow(img_max);title("经过5*5最大值滤波器处理后的图像");

%% 5*5中点滤波器
[rows,cols] = size(img_pad);
img_mid = zeros(rows,cols);
max = -9999;
min = 9999;
for i = 3:rows-2
    for j = 3:cols-2
        for m = 1:5
            for n =1:5
                if(img_pad(i-3+m,j-3+n)>max)
                    max = img_pad(i-3+m,j-3+n);
                end
                if(img_pad(i-3+m,j-3+n)<min)
                    min = img_pad(i-3+m,j-3+n);
                end
            end
        end
        img_mid(i,j) = 1/2 * (max + min);
        max = -9999;
        min = 9999;
    end
end
img_mid = img_mid(3:256,3:256);
figure;imshow(img_mid);title("经过5*5中点滤波器处理后的图像");

