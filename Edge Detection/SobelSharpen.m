function outImg4 = SobelSharpen(inImg)
%SobelSharpen 利用Sobel算子提取原图像的边缘信息
%   此处提供详细说明

% 检测x方向边缘的Sobel算子
S_x = [-1,0,1;
       -2,0,2;
       -1,0,1];

% 检测y方向边缘的Sobel算子
S_y = [-1,-2,-1;
        0, 0, 0;
        1, 2, 1];

[w,h] = size(inImg);        % 获取图像行列
Grad_x = zeros(w,h);        % 创建x方向一阶导图像矩阵
Grad_y = zeros(w,h);        % 创建y方向一阶导图像矩阵
Edge_img = zeros(w,h);      % 创建提取边缘后的图像矩阵

% 输入图像与Sobel算子卷积
Grad_x = imfilter(inImg,S_x,'symmetric');
Grad_y = imfilter(inImg,S_y,'symmetric');
Grad_x = im2double(Grad_x);
Grad_y = im2double(Grad_y);

% 计算最终的梯度图像
for i = 1:w
    for j = 1:h
        Edge_img(i,j) = (Grad_x(i,j)^2 + Grad_y(i,j)^2)^(1/2);
    end
end

outImg4 = im2uint8(Edge_img);

end