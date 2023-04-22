clc
clear

% 测试图像
img = [21,21,21,95,169,243,243,243;
       21,21,21,95,169,243,243,243;
       21,21,21,95,169,243,243,243;
       21,21,21,95,169,243,243,243];

% 图像大小
[w,h] = size(img);

% 各灰度值的概率
p_21 = length(find(img == 21))/ (w * h);
p_95 = length(find(img == 95)) / (w * h);
p_169 = length(find(img == 169)) / (w * h);
p_243 = length(find(img == 243)) / (w * h);

% 灰度信源
signal = [21,95,169,243];
% 灰度信源的概率空间
P = [p_21,p_95,p_169,p_243];

%计算信源的信息熵
H = 0;
for i = 1:4
    H = H - P(i) * log2(P(i));
end

% 进行霍夫曼编码
P = sort(P);
huffman_code = huffmandict(signal,P);

% 计算霍夫曼编码后的压缩比
L_avg = 8;          % 采用8bit固定码长描述灰度信源的平均比特数
L_huffman = 0;      % 计算经过霍夫曼编码后的灰度信源平均比特数
for i = 1:length(signal)
    len = length(cell2mat(huffman_code(i,2)));
    L_huffman = L_huffman + P(i) * len;
end

C = L_huffman/L_avg;

% 采用霍夫曼编码后相较于8bit固定编码 压缩率为23% 降低了编码冗余
% 经过计算可以发现霍夫曼编码后的平均比特数已经非常接近该图像的信源熵了

disp("该灰度信源的信息熵为");
disp(H);

disp("对灰度信源进行霍夫曼编码结果")
disp(huffman_code)

disp("经过霍夫曼编码后的平均比特数")
disp(L_huffman)

disp("经过霍夫曼编码后的压缩率")
disp(C)




