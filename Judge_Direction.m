function [flag, rect] = Judge_Direction(bw)                                %判断横向、纵向裂缝；flag方向标记，rect裂缝矩形框
[~, num] = bwlabel(bw);                                                    %区域标记
stats = regionprops(bw, 'Area', 'BoundingBox');                            %区域属性
Area = cat(1, stats.Area);                                                 %面积信息
[~, ind] = sort(Area, 'descend');                                          %最大面积
if num == 1
    rect = stats.BoundingBox;
else
    rect1 = stats(ind(1)).BoundingBox;
    rect2 = stats(ind(2)).BoundingBox;
    s1 = [rect1(1); rect2(1)];
    s2 = [rect1(2); rect2(2)];    
    s = [min(s1) min(s2) rect1(3)+rect2(3) rect1(4)+rect2(4)];
    rect = s;
end
rate = rect(3)/rect(4);                                                    %比率
if rate > 1
    flag = 1;                                                              %横向裂缝
else
    flag = 2;                                                              %纵向裂缝
end