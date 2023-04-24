function outImg5 = HistImgSegement(inImg)
%HistImgSegement 基于直方图峰值特性选择灰度阈值进行图像全局二值化
%   此处提供详细说明

% 获取输入图像直方图
hist = imhist(inImg);

% 迭代计数器
iteration = 0;

%% 直方图平滑为双峰直方图过程
while true
    % 统计当前直方图中的峰值个数
    count = 0;
    for i = 2:255
        % 峰值判断条件
        if(hist(i) > hist(i-1) && hist(i) > hist(i+1))
            count = count + 1;
        end
    end
    % 如果经过峰值个数为2 则跳出while
    if(count == 2)
        break;
    elseif(count > 2)
        % 若峰值个数大于2  则用滑动平均滤波器平滑直方图
        hist(1) = (hist(1) + hist(1) + hist(2)) * 1/3;          % 第一个点
        for j = 2:255
            hist(j) = (hist(j-1) + hist(j) + hist(j+1)) * 1/3;  % 中间点
        end
        hist(256) = (hist(255) + hist(255) + hist(256)) * 1/3;  % 最后一个点
    else
        % 如果是单峰则报错
        Error("Can not handle the histogram whith single peak ");
    end
    % 当迭代超过1000次则跳出while
    iteration = iteration + 1;
    if(iteration >= 1001)
        break;
    end
    % 画出平滑后的直方图 可以与原图像直方图做比较
    figure(3);plot(1:256,hist);title("用滑动滤波器不断平滑灰度直方图");
    pause(0.075);
end

peak_1 = 0;         % 第一个峰值的灰度值
peak_2 = 0;         % 第二个峰值的灰度值
threshold = 0;      % 二值化阈值

%% 寻找第一个峰值
for k = 2 : 255
    if(hist(k) > hist(k-1) && hist(k) > hist(k+1))
        peak_1 = k;
        break;
    end
end

%% 寻找第二个峰值
for l = peak_1 + 1 : 255
    if(hist(l) > hist(l-1) && hist(l) > hist(l+1))
        peak_2 = l;
        break;
    end
end

%% 在两个峰值中寻找谷底
for m = peak_1 + 1 : peak_2 - 1
    if(hist(m) < hist(m-1) && hist(m) < hist(m+1))
        threshold = m;
    end
end

%% 图像全局二值化处理
[w,h] = size(inImg);
outImg5 = zeros(w,h);

for i = 1:w
    for j = 1:h
        if(inImg(i,j) >= (threshold - 1))
            outImg5(i,j) = 0;
        elseif(inImg(i,j) < (threshold - 1))
            outImg5(i,j) = 255;
        end
    end
end

end

