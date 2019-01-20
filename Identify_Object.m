function bwn = Identify_Object(bw, MinArea, MinRate)                       %识别裂缝目标（二值化连通区域长短轴的比）；bw二值图像，MinArea最小面积，MinRate最小长短轴之比，bwn识别结果
if nargin < 3
    MinRate = 3;                                                           %最小长短轴之比
end
if nargin < 2
    MinArea = 20;                                                          %最小面积
end
[L, num] = bwlabel(bw);                                                    %区域标记
stats = regionprops(L, 'Area', 'MajorAxisLength', ...
    'MinorAxisLength');                                                    %计算区域属性信息
Ap = cat(1, stats.Area);                                                   %统计面积信息
Lp1 = cat(1, stats.MajorAxisLength);                                       %统计长轴信息
Lp2 = cat(1, stats.MinorAxisLength);                                       %统计短轴信息
Lp = Lp1./Lp2;                                                             %长短轴之比
for i = 1 : num                                                            %面积滤波
    if Ap(i) < MinArea
        bw(L == i) = 0;
    end
end
MinRate = max(Lp)*0.4;                                                     %长短轴之比滤波
for i = 1 : num
    if Lp(i) < MinRate
        bw(L == i) = 0;
    end
end
bwn = bw;
