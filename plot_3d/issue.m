clc
clear

%读入图像文件并转换为灰度图像
img = imread("test.jpg");
img = rgb2gray(img);

%展示导入的灰度图像
figure
imshow(img);
impixelinfo
title('导入灰度图像')
hold on

%绘出图像灰度值的三维图像
[rows,cols] = size(img);
[X,Y] = meshgrid(1:cols,1:rows);
img = flip(img,1);

figure
mesh(X,Y,img,'LineWidth',0.5);
title('像素强度与（x,y）坐标关系图')
hold on

%随机选定三行像素序列和两列像素序列
Selected_rows = floor(unifrnd(0,rows,[1,3]));
Selected_cols = floor(unifrnd(0,cols,[1,2]));

row1_pixel = img(Selected_rows(1),:);
row2_pixel = img(Selected_rows(2),:);
row3_pixel = img(Selected_rows(3),:);
col1_pixel = img(:,Selected_cols(1));
col2_pixel = img(:,Selected_cols(2));

m = repelem(Selected_rows(1),cols);
n = repelem(Selected_rows(2),cols);
q = repelem(Selected_rows(3),cols);
a = repelem(Selected_cols(1),rows);
b = repelem(Selected_cols(2),rows);

X = 1:1:cols;
Y = 1:1:rows;

%展示三行四列的像素强度-(x,y)曲线
figure
plot3(X,m,row1_pixel,'LineWidth',2);
hold on
plot3(X,n,row2_pixel,'LineWidth',2);
hold on
plot3(X,q,row3_pixel,'LineWidth',2);
hold on
plot3(a,Y,col1_pixel,'LineWidth',2);
hold on
plot3(b,Y,col2_pixel,'LineWidth',2);
hold on
title("随机抽取的三行两列的像素强度-(x,y)曲线")
legend('第一个随机抽取的行的像素强度曲线', ...
    '第二个随机抽取的行的像素强度曲线', ...
    '第三个随机抽取的行的像素强度曲线', ...
    '第一个随机抽取的列的像素强度曲线', ...
    '第二个随机抽取的列的像素强度曲线')


