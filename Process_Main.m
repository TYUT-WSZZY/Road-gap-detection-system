function Result=Process_Main(I)
if ndims(I) == 3                                                           %灰度化
    I1 = rgb2gray(I);
else
    I1 = I;
end
I2 = hist_con(I1);                                                         %灰度变换
I3 = Med_Process(I2);                                                      %中值滤波去噪
I4 = adjgamma(I3);                                                         %图像增强
[bw, th] = IterProcess(I4);                                                %迭代阈值处理-二值图像
bw = ~bw;                                                                  %反色
bwn1 = bw_filter(bw, 15);                                                  %二值图像滤波
bwn2 = Identify_Object(bwn1);                                              %裂缝识别
[projectr, projectc] = Project(bwn2);                                      %曲线投影
[r, c] = size(bwn2);
bwn3 = Judge_Crack(bwn2, I4);                                              %裂缝判断
bwn4 = Bridge_Crack(bwn3);                                                 %裂缝拼接
[flag, rect] = Judge_Direction(bwn4);                                      %裂缝形状识别
if flag == 1
    str = '横向裂缝';
    wdmax = max(projectc);
    wdmin = min(projectc);
else
    str = '纵向裂缝';
    wdmax = max(projectr);
    wdmin = min(projectr);
end
Result.Image = I1;                                                         %输入图像
Result.hist = I2;                                                          %灰度变换
Result.Medfilt = I3;                                                       %中值滤波去噪
Result.Enance = I4;                                                        %图像增强
Result.Bw = bw;                                                            %二值图像
Result.BwFilter = bwn1;                                                    %二值图像滤波
Result.CrackRec = bwn2;                                                    %裂缝识别
Result.Projectr = projectr;                                                %裂缝投影
Result.Projectc = projectc;
Result.CrackJudge = bwn3;                                                  %裂缝判断
Result.CrackBridge = bwn4;                                                 %裂缝拼接
Result.str = str;                                                          %裂缝形状
Result.rect = rect;                                                        %裂缝标记
Result.BwEnd = bwn4;                                                       %最后的二值图像 
Result.BwArea = bwarea(bwn4);                                              %面积信息
Result.BwLength = max(rect(3:4));                                          %长度信息
Result.BwWidthMax = wdmax;                                                 %宽度信息
Result.BwWidthMin = wdmin; 
Result.BwTh = th;                                                          %阈值信息