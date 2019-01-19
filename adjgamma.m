function newim = adjgamma(im, g)                                           %ͼ����ǿ
if nargin < 2
    g = 1;
end                                                                        %�ж������������.
if g <= 0
    error('Gamma�����������0');
end
if ndims(im) == 3                                                          %��ʾ��ά����.
    I = rgb2gray(im);                                                      %�ҶȻ�����
else
    I = im;
end
if isa(I,'uint8')                                                          %�ж���������Ƿ�Ϊָ�����͵Ķ���.
    newim = double(I);
else
    newim = I;
end
newim = newim-min(min(newim));
newim = newim./max(max(newim));
newim =  newim.^g;

