function newim = adjgamma(im, g)                                           %图像增强
if nargin < 2
    g = 1;
end                                                                        %判断输入变量个数.
if g <= 0
    error('Gamma参数必须大于0');
end
if ndims(im) == 3                                                          %表示几维数组.
    I = rgb2gray(im);                                                      %灰度化处理
else
    I = im;
end
if isa(I,'uint8')                                                          %判断输入参量是否为指定类型的对象.
    newim = double(I);
else
    newim = I;
end
newim = newim-min(min(newim));
newim = newim./max(max(newim));
newim =  newim.^g;

