function [H,D] = lpfilter(type,M,N,D0,n)
% 参数列表需要提供：
%       滤波器类型
%       滤波器核大小
%       截止频率
%       滤波器阶数
% 该函数可以返回理想低通滤波器、高斯低通滤波器以及巴特沃斯低通滤波器
[U,V] = dftuv(M,N);
D = sqrt(U.^2 + V.^2);

switch type
    case 'Ideal'
        H = double(D <= D0);
    case 'ButterWorth'
        if nargin == 4
            n = 2;
        end
        H = 1./(1 + (D./D0).^(2*n));
    case 'Gaussian'
        H = exp(-(D.^2)./(2*(D0^2)));
    otherwise
        error('Unknown filter type.')
end