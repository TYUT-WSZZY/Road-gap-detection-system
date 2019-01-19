function s_out = Med_Process(s_in, flag)    %图像平滑--中值滤波去噪
if nargin < 2
    flag = 0;
end
if ndims(s_in) == 3
    I = rgb2gray(s_in);
else
    I = s_in;
end
s_out= medfilt2(I ,[3 ,3]);
if flag
    figure;
    subplot(221);imshow(I); title('原图');
    subplot(222);imhist(I); title('原图');
    subplot(223);imshow(s_out,[]);title('中值滤波平滑图像');
    subplot(224);imhist(s_out);title('中值滤波平滑图像');
end