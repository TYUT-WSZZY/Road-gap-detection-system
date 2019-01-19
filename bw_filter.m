function bwn = bw_filter(bw, keepnum)                                      %二值图像去噪；bw二值图像，keepnum保留数目，bwn去噪后的二值图像
if nargin < 2
    keepnum = 15;
end
[L, num] = bwlabel(bw, 8);                                                 %标记
Ln = zeros(1, num);                                                        %记录像素个数
stats = regionprops(L, 'Area');                                            %面积属性
Ln = cat(1, stats.Area);
[Ln, ind] = sort(Ln);                                                      %排序
if num>keepnum || num==keepnum
    for i = 1 : num-keepnum
        bw(L == ind(i)) = 0;                                               %消除
    end
end
bwn = bw;                                                                  %赋值
