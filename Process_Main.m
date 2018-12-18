function Result=Process_Main(I)
if ndims(I) == 3                                                           %�ҶȻ�
    I1 = rgb2gray(I);
else
    I1 = I;
end
I2 = hist_con(I1);                                                         %�Ҷȱ任
I3 = Med_Process(I2);                                                      %��ֵ�˲�ȥ��
I4 = adjgamma(I3);                                                         %ͼ����ǿ
[bw, th] = IterProcess(I4);                                                %������ֵ����-��ֵͼ��
bw = ~bw;                                                                  %��ɫ
bwn1 = bw_filter(bw, 15);                                                  %��ֵͼ���˲�
bwn2 = Identify_Object(bwn1);                                              %�ѷ�ʶ��
[projectr, projectc] = Project(bwn2);                                      %����ͶӰ
[r, c] = size(bwn2);
bwn3 = Judge_Crack(bwn2, I4);                                              %�ѷ��ж�
bwn4 = Bridge_Crack(bwn3);                                                 %�ѷ�ƴ��
[flag, rect] = Judge_Direction(bwn4);                                      %�ѷ���״ʶ��
if flag == 1
    str = '�����ѷ�';
    wdmax = max(projectc);
    wdmin = min(projectc);
else
    str = '�����ѷ�';
    wdmax = max(projectr);
    wdmin = min(projectr);
end
Result.Image = I1;                                                         %����ͼ��
Result.hist = I2;                                                          %�Ҷȱ任
Result.Medfilt = I3;                                                       %��ֵ�˲�ȥ��
Result.Enance = I4;                                                        %ͼ����ǿ
Result.Bw = bw;                                                            %��ֵͼ��
Result.BwFilter = bwn1;                                                    %��ֵͼ���˲�
Result.CrackRec = bwn2;                                                    %�ѷ�ʶ��
Result.Projectr = projectr;                                                %�ѷ�ͶӰ
Result.Projectc = projectc;
Result.CrackJudge = bwn3;                                                  %�ѷ��ж�
Result.CrackBridge = bwn4;                                                 %�ѷ�ƴ��
Result.str = str;                                                          %�ѷ���״
Result.rect = rect;                                                        %�ѷ���
Result.BwEnd = bwn4;                                                       %���Ķ�ֵͼ�� 
Result.BwArea = bwarea(bwn4);                                              %�����Ϣ
Result.BwLength = max(rect(3:4));                                          %������Ϣ
Result.BwWidthMax = wdmax;                                                 %�����Ϣ
Result.BwWidthMin = wdmin; 
Result.BwTh = th;                                                          %��ֵ��Ϣ