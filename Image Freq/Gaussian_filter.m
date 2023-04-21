function [img_return] = Gaussian_filter(img,time)
%Gaussian_filter 高斯滤波器
%对输入的图像进行time次高斯平滑滤波，使得条纹相间处的边缘灰度值变化的更连续
    w = fspecial('gaussian');
    img_output = img;
    img_result(:,:,1) = img; 
    for i = 1:time
        img_output = imfilter(img_output,w,'conv','symmetric','same');
        img_result(:,:,i+1) = img_output;
    end
    img_return = img_result(:,:,time);
end