function s_out = Med_Process(s_in, flag)    %ͼ��ƽ��--��ֵ�˲�ȥ��
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
    subplot(221);imshow(I); title('ԭͼ');
    subplot(222);imhist(I); title('ԭͼ');
    subplot(223);imshow(s_out,[]);title('��ֵ�˲�ƽ��ͼ��');
    subplot(224);imhist(s_out);title('��ֵ�˲�ƽ��ͼ��');
end