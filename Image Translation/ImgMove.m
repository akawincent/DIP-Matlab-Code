function outImg2 = ImgMove(inImg,Tx,Ty)
% ImgMove 图像几何平移变换函数
%   
    [w,h] = size(inImg);            % 获取图像行列
    outImg2 = zeros(w,h);           % 创建输出图像矩阵

    % 平移变换矩阵(注意这里是齐次矩阵形式)
    Trans_Mat = [1,0,Tx;            
                 0,1,Ty;
                 0,0,1;];
%%  平移变换
    for i = 1:w
        for j = 1:h
            % 当前遍历像素的齐次坐标
            now_position = [i;j;1];     
            % 计算经过平移变换后的新坐标位置
            new_position = Trans_Mat * now_position;
            % 从齐次坐标中提取x y 坐标值
            x = new_position(1,1);
            y = new_position(2,1);
            % 判断新坐标值是否合理
            if(x >= 1 && x <= w && y >= 1 && y <= h)
                % 将原坐标值的灰度赋值给新坐标值处的像素
                outImg2(x,y) = inImg(i,j);
            end
        end
    end
end