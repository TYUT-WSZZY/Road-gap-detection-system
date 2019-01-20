function bwn = Identify_Object(bw, MinArea, MinRate)                       %ʶ���ѷ�Ŀ�꣨��ֵ����ͨ���򳤶���ıȣ���bw��ֵͼ��MinArea��С�����MinRate��С������֮�ȣ�bwnʶ����
if nargin < 3
    MinRate = 3;                                                           %��С������֮��
end
if nargin < 2
    MinArea = 20;                                                          %��С���
end
[L, num] = bwlabel(bw);                                                    %������
stats = regionprops(L, 'Area', 'MajorAxisLength', ...
    'MinorAxisLength');                                                    %��������������Ϣ
Ap = cat(1, stats.Area);                                                   %ͳ�������Ϣ
Lp1 = cat(1, stats.MajorAxisLength);                                       %ͳ�Ƴ�����Ϣ
Lp2 = cat(1, stats.MinorAxisLength);                                       %ͳ�ƶ�����Ϣ
Lp = Lp1./Lp2;                                                             %������֮��
for i = 1 : num                                                            %����˲�
    if Ap(i) < MinArea
        bw(L == i) = 0;
    end
end
MinRate = max(Lp)*0.4;                                                     %������֮���˲�
for i = 1 : num
    if Lp(i) < MinRate
        bw(L == i) = 0;
    end
end
bwn = bw;
