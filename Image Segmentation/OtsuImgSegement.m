function outImg = OtsuImgSegement(inImg)
%OtsuSegement Otsu算法最大化类间方差选择灰度阈值进行图像全局二值化
%   此处提供详细说明

[w,h] = size(inImg);                    % 获取图像行列
Hist = imhist(inImg);                   % 获取图像直方图
Hist_Norm = Hist./(w * h);              % 获取归一化直方图
ZeroCumuMoment = zeros(size(Hist));     % 创建灰度直方图的零阶累积矩(累加直方图)
OneCumuMoment = zeros(size(Hist));      % 创建灰度直方图的一阶累积矩

%% 计算输入图像灰度直方图的零阶累积矩和一阶累积矩
for i = 1:256
    if(i == 1)
        ZeroCumuMoment(i) = Hist_Norm(i);
        OneCumuMoment(i) = Hist_Norm(i);
    else
        ZeroCumuMoment(i) = ZeroCumuMoment(i-1) + Hist_Norm(i);
        OneCumuMoment(i) = OneCumuMoment(i-1) + i * Hist_Norm(i);
    end   
end

%% 计算输入图像总的灰度平均值  实际上就是k = 256时的一阶矩
Total_mean = OneCumuMoment(256);

%% 计算类间方差并取最大类间方差 同时记录阈值
Var = 0;            % 计算的类间方差
threshold = 0;      % 阈值
Var_max = 0;        % 最大的类间方差

for j = 1:256
    % 防止分母为0  数据计算异常
    if(ZeroCumuMoment(j) == 0 || ZeroCumuMoment(j) == 1)
        Var = 0;
    % 计算类间方差
    else
        Var = (Total_mean * ZeroCumuMoment(j) - OneCumuMoment(j))^2 ...
               / (ZeroCumuMoment(j) * (1 - ZeroCumuMoment(j)));
    end
    if (Var > Var_max)
        Var_max = Var;          % 记录最大的类间方差
        threshold = j - 1;      % 此时的灰度便是阈值
    end
end

%% 二值化处理
outImg = zeros(w,h);
for m = 1:w
    for n = 1:h
        if(inImg(m,n) >= threshold)
            outImg(m,n) = 255;
        elseif(inImg(m,n) < threshold)
            outImg(m,n) = 0;
        end
    end
end

end