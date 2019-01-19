function s_out = hist_con(s_in, flag)  %图像增强
if nargin < 2
    flag = 0;
end
if ndims(s_in) == 3
    I = rgb2gray(s_in);
else
    I = s_in;
end
s_out=imadjust(I,[0.1 0.7],[0 1],1);
if flag
    figure;
    subplot(121);imshow(I); title('原图');
    subplot(122);imshow(s_out);title('灰度变换后的原图');
end
