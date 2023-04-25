function outImg8 = Colorbalance(inImg)
%Colorbalance 彩色平衡函数 利用灰度世界法
%   灰度世界理论：认为任何一幅图像, 当有足够的色彩变化时, 
%   其R, G, B分量均值会趋于平衡。将原始图的RGB均值分别调
%   整到R= G = B即可完成色彩平衡。

% 分离RGB三通道图像矩阵
inImg_R = inImg(:,:,1);
inImg_G = inImg(:,:,2);
inImg_B = inImg(:,:,3);

% 求输入图像中三通道的RGB均值
R_average = mean2(inImg_R);
G_average = mean2(inImg_G); 
B_average = mean2(inImg_B);
% 系数K
K = (R_average + G_average + B_average) / 3;

% 矫正RGB 使得三通道均值R = G = B
R_correct = (K./R_average).*inImg_R;
G_correct = (K./G_average).*inImg_G;
B_correct = (K./B_average).*inImg_B;

outImg8 = zeros(size(inImg));
outImg8(:,:,1) = R_correct;
outImg8(:,:,2) = G_correct;
outImg8(:,:,3) = B_correct;

outImg8 = uint8(outImg8);

end