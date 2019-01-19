function [bw, th] = IterProcess(Img)                                       %迭代法进行二值化；Img图像矩阵，bw二值图像，th阈值
if ndims(Img) == 3                                                         %图像灰度处理
    I = rgb2gray(Img);
else
    I = Img;
end

T0 = (double(max(I(:))) + double(min(I(:))))/2;                            %初始化阈值
flag = 1;                                                                  %循环控制

while flag
    ind1 = I > T0;                                                         %阈值分割
    ind2 = ~ind1;
    T1 = (mean(double(I(ind1))) + mean(double(I(ind2))))/2;                %计算新阈值
    flag = abs(T1-T0) > 0.5;                                               %判断条件
    T0 = T1;                                                               %更新阈值
end
bw = ind1;                                                                 %赋值
th = T1;
