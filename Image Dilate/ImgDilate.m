function outImg6 = ImgDilate(inImg,Template)
%ImgErose 对二值图像连续进行数次膨胀
%   此处提供详细说明

[w,h] = size(inImg);            % 获取图像行列
[w1,h1] = size(Template);       % 获取核的行列
outImg6 = zeros(w,h);           % 创建输出图像矩阵

%% 膨胀过程
for i = 1 + (w1-1)/2 : w - (w1-1)/2
    for j = 1 + (h1-1)/2:h - (h1-1)/2
        % 取输入图像与核大小一样的邻域(不断遍历的)
        pattern = inImg(i-(w1-1)/2:i + (w1-1)/2,j-(h1-1)/2:j+(h1-1)/2);
        % 注意这里不是卷积 而是对应元素相乘
        temp = pattern .* Template; 
        % 如果temp的和大于0 说明pattern中必有非零值
        if sum(temp(:)) > 0 
            outImg6(i,j) = 1;
        else
            outImg6(i,j) = 0;
        end
    end
end


end