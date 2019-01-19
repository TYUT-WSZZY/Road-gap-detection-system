function bwn = Judge_Crack(bw, Ig, th)                                     %�ѷ��ж�
if nargin < 3
    th = 20;
end
[L, num] = bwlabel(bw);                %����ͨ����
Ig = im2uint8(mat2gray(Ig));           %mat2gray�ǰ�һ��double�������ת����ȡֵ��ΧΪ[0,1]�Ĺ�һ��double������
                                       %im2uint8���ڽ���һ����0��1֮�䣨im2double������ͼ��ת��Ϊuint8����
Ig = double(Ig);
stats = regionprops(L, 'Area', 'BoundingBox');%'Area'?ͼ����������������ܸ�����'BoundingBox'  ������Ӧ�������С����
for i = 1 : num
    Ymin = round(stats(i).BoundingBox(1));    %��������ȡ����ֵ
    Ymax = round(stats(i).BoundingBox(1) + stats(i).BoundingBox(3));
    Xmin = round(stats(i).BoundingBox(2));
    Xmax = round(stats(i).BoundingBox(2) + stats(i).BoundingBox(4));
    sum1(i) = 0; 
    for k1 = Xmin : Xmax-1
        for k2 = Ymin : Ymax-1
            sum1(i) = sum1(i) + Ig(k1, k2);
        end
    end
    RectArea(i) = stats(i).BoundingBox(3)*stats(i).BoundingBox(4);         %��þ���
    Average1(i) = sum1(i)/RectArea(i);                                     %������ƽ��ֵ
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
end                                                                        %ɾ��<20��
bwn = bw;