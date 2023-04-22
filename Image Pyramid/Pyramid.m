clc
clear;

%% 原图像灰度矩阵
img_origin = [11,12,13,14;
              15,16,17,18;
              19,20,21,22;
              23,24,25,26];
img_origin = uint8(img_origin);

%% Approximation filter采用高斯低通卷积核来降低图像频率
% 如果是直接对高清图片进行Downsampler，需要的采样率会很高容易造成下采样的混叠
w = fspecial('gaussian');               % 构造3*3的高斯低通卷积滤波核
img_filtered = imfilter(img_origin,w,'conv','symmetric','same');    %滤波过程

%% 对高斯模糊后的4*4图像进行2倍的图像下采样操作 构造下一级的金字塔图像
img_downsampler = zeros(2);              % 创建下采样矩阵
srcW = 2; srcH = 2; dstW = 1; dstH = 1;  % 缩放比例

%注意在OpenCV中矩阵起点是从零开始的
dstX_1 = 1 - 1; dstX_2 = 2 - 1;          % 目标缩小图像的横坐标
dstY_1 = 1 - 1; dstY_2 = 2 - 1;          % 目标缩小图像的纵坐标

% 为了保证图像缩小前后的中心对齐  不能简单地去选取整数行列
% 采用类似于OpenCV库的缩放像素坐标公式保证两者图像中心对齐
% 得到了目标缩小图像的坐标和源图像坐标的对应关系
srcX(1) = (dstX_1 + 0.5) * srcW/dstW - 0.5;     
srcX(2) = (dstX_2 + 0.5) * srcW/dstW - 0.5;
srcY(1) = (dstY_1 + 0.5) * srcH/dstH - 0.5;
srcY(2) = (dstY_2 + 0.5) * srcH/dstH - 0.5;

%为了在Matlab中进行矩阵运算 要把坐标预处理减去的1 加回来
srcX(1) = srcX(1) + 1;srcX(2) = srcX(2) + 1;
srcY(1) = srcY(1) + 1;srcY(2) = srcY(2) + 1;

% 容易发现src的坐标都是浮点值，因此我们需要用双线性插值法计算出亚像素级的灰度值
for i = 1:2
    for j = 1:2
        xx = srcX(i) - floor(srcX(i));
        yy = srcY(j) - floor(srcY(j));
        ky_1 = img_filtered(floor(srcX(i)),ceil(srcY(j)))...
                - img_filtered(floor(srcX(i)),floor(srcY(j)))...
                   /(ceil(srcY(j)) - floor(srcY(j)));
        ky_2 = img_filtered(ceil(srcX(i)),ceil(srcY(j)))...
                - img_filtered(ceil(srcX(i)),floor(srcY(j)))...
                   /(ceil(srcY(j)) - floor(srcY(j)));
        temp_1 = img_filtered(floor(srcX(i)),floor(srcY(j))) + ky_1 * yy;
        temp_2 = img_filtered(ceil(srcX(i)),floor(srcY(j))) + ky_2 * yy;
        kx_temp = (temp_2 - temp_1)/(ceil(srcX(i)) - floor(srcX(i)));
        final = temp_1 + kx_temp * xx;
        img_downsampler(i,j) = final;
    end
end

%% 对上一级金字塔的图像进行2倍的上采样 将其恢复到4*4大小
img_upsampler = zeros(4);               % 创建上采样矩阵
srcW = 1; srcH = 1; dstW = 2; dstH = 2; % 缩放比例

% 目标放大图像的像素位置坐标(采样OpenCV中的矩阵坐标)
dstX = [0,1,2,3];
dstY = [0,1,2,3];

% 计算坐标映射关系
srcX = (dstX + 0.5) .* srcW/dstW - 0.5;
srcY = (dstY + 0.5) .* srcW/dstW - 0.5;

%为了在Matlab中进行矩阵运算 要把坐标预处理减去的1 加回来
srcX = srcX + 1; srcY = srcY + 1;

% 可以发现放大过程的坐标映射会产生像素坐标数值的溢出  e.g. 0.75和2.25
% 这里需要对不同位置的像素采取不同的插值策略
% 对于srcX和srcY坐标范围正常的 4*4图像中间的4个点 采用双线性插值
for i = 2:3
    for j = 2:3
        xx = srcX(i) - floor(srcX(i));
        yy = srcY(j) - floor(srcY(j));
        ky_1 = img_downsampler(floor(srcX(i)),ceil(srcY(j)))...
                - img_downsampler(floor(srcX(i)),floor(srcY(j)))...
                   /(ceil(srcY(j)) - floor(srcY(j)));
        ky_2 = img_downsampler(ceil(srcX(i)),ceil(srcY(j)))...
                - img_downsampler(ceil(srcX(i)),floor(srcY(j)))...
                   /(ceil(srcY(j)) - floor(srcY(j)));
        temp_1 = img_downsampler(floor(srcX(i)),floor(srcY(j))) + ky_1 * yy;
        temp_2 = img_downsampler(ceil(srcX(i)),floor(srcY(j))) + ky_2 * yy;
        kx_temp = (temp_2 - temp_1)/(ceil(srcX(i)) - floor(srcX(i)));
        final = temp_1 + kx_temp * xx;
        img_upsampler(i,j) = final;
    end
end

% 对于4*4图像边缘的点（除顶点）采用线性插值
img_upsampler(1,2) =  img_upsampler(2,2) - (img_upsampler(3,2) - img_upsampler(2,2));
img_upsampler(1,3) =  img_upsampler(2,3) - (img_upsampler(3,3) - img_upsampler(2,3));
img_upsampler(4,2) =  img_upsampler(3,2) - (img_upsampler(2,2) - img_upsampler(3,2));
img_upsampler(4,3) =  img_upsampler(3,3) - (img_upsampler(2,3) - img_upsampler(3,3));
img_upsampler(2,1) =  2 * img_upsampler(2,2) - img_upsampler(2,3);
img_upsampler(3,1) =  2 * img_upsampler(3,2) - img_upsampler(3,3);
img_upsampler(2,4) =  2 * img_upsampler(2,3) - img_upsampler(2,2);
img_upsampler(3,4) =  2 * img_upsampler(3,3) - img_upsampler(3,2);

% 对于4*4图像顶点 采用最邻近插值
img_upsampler(1,1) = img_downsampler(1,1);
img_upsampler(1,4) = img_downsampler(1,2);
img_upsampler(4,1) = img_downsampler(2,1);
img_upsampler(4,4) = img_downsampler(2,2);

img_upsampler = uint8(img_upsampler);

%% 拉普拉斯金字塔图像 即residual
Laplacian = [-1,-1,-1,-1;
             -1,-1,-1,-1;
             -1,-1,-1,-1;
             -1,-1,-1,-1];
Laplacian = int8(img_origin) - int8(img_upsampler);

% 观察残差矩阵我们可以发现 主要的误差都集中在顶点处，也就是直接使用最邻近插值的像素
% 对于本例来说 由于其图像表现出过强的线性特性 因此使用线性插值法才是最佳的插值算法
% 然而并不是所有的图像都有如此特性 一般的图像都是具有高度的非凸特性 图像梯度变化并不规律
% 因此在本例 对顶点的处理的确是线性插值更优，但是在其他的图片中可能是最邻近插值来处理顶点是最优的
% 本程序只是将不同的插值算法策略尝试应用在多样的场景,而本例中的测试样例也告诉我们
% 所有的算法都只是考虑了更一般的普适情况  并不存在放之四海而皆准的算法 
% 要学会具体分析工程应用场景而适当的做出调整

figure(1);imshow(img_origin,'InitialMagnification','fit');title("测试用像素块")
figure(2);imshow(uint8(img_filtered),'InitialMagnification','fit');title("高斯低通滤波后的像素块")
figure(3);imshow(uint8(img_downsampler),'InitialMagnification','fit');title("下采样2倍后的下一级金字塔图像");
figure(4);imshow(uint8(img_upsampler),'InitialMagnification','fit');title("上采样2倍后恢复的4*4大小图像");

disp("经过下采样后的下一级金字塔图像")
disp(img_downsampler)
disp("经过上采样后的恢复的4*4大小图片")
disp(img_upsampler)
disp("残差图像即拉普拉斯金字塔 存储着高频信息")
disp(Laplacian)