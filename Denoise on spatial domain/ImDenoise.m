function outImg3 = ImDenoise(inImg,deNoiseStyle)
%ImDenoise 图像空间滤波函数
%   该函数通过deNoiseStyle参数的不同来选择两种不同的滤波策略
%   'medan':此时函数执行中值滤波，主要处理被椒盐噪声污染过的图像
%   'average':此时函数执行均值滤波，主要处理被高斯噪声污染过的图像

[w,h] = size(inImg);                    % 获取图像行列
outImg3 = zeros(w,h);                   % 创建输出图像矩阵

% 统一将字符型变量参数转换为小写字母进行判断
switch lower(deNoiseStyle) 
    % 中值滤波
    case 'medan'
        m = 5; n = 5;                   % 空间滤波的邻域大小
        outImg3 = medfilt2(inImg,[m n],'symmetric');
    % 均值滤波 这里采用算术平均滤波
    case 'average'
        m = 9; n = 9;                    % 空间滤波的邻域大小
        w = 1/m * 1/n * ones(m,n);       % 滤波器核
        outImg3 = imfilter(inImg,w,'symmetric');
    otherwise
        error('Unknown distribution type.')
end