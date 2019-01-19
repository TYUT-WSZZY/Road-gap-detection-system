function bwn = Judge_Crack(bw, Ig, th)                                     %裂缝判断
if nargin < 3
    th = 20;
end
[L, num] = bwlabel(bw);                %找连通区域
Ig = im2uint8(mat2gray(Ig));           %mat2gray是把一个double类的数组转换成取值范围为[0,1]的归一化double类数组
                                       %im2uint8用于将归一化到0～1之间（im2double处理后的图像）转换为uint8类型
Ig = double(Ig);
stats = regionprops(L, 'Area', 'BoundingBox');%'Area'?图像各个区域中像素总个数；'BoundingBox'  包含相应区域的最小矩形
for i = 1 : num
    Ymin = round(stats(i).BoundingBox(1));    %四舍五入取整数值
    Ymax = round(stats(i).BoundingBox(1) + stats(i).BoundingBox(3));
    Xmin = round(stats(i).BoundingBox(2));
    Xmax = round(stats(i).BoundingBox(2) + stats(i).BoundingBox(4));
    sum1(i) = 0; 
    for k1 = Xmin : Xmax-1
        for k2 = Ymin : Ymax-1
            sum1(i) = sum1(i) + Ig(k1, k2);
        end
    end
    RectArea(i) = stats(i).BoundingBox(3)*stats(i).BoundingBox(4);         %求得矩形
    Average1(i) = sum1(i)/RectArea(i);                                     %求向量平均值
    [r, c] = find(L == i);
    Ln(i) = length(find(L==i));
    for j = 1 : Ln(i)
        gv(i, j) = Ig(r(j), c(j));
    end
    sum2(i) = sum(gv(i, :));
    Average2(i) = sum2(i)/Ln(i);
    Sub(i) = abs(Average1(i) - Average2(i));
    if Sub(i) < th
        bw(find(L==i)) = 0;
    end
end                                                                        %删除<20的
bwn = bw;