%macroblock generation for testing
clc;
clear all;

%creating macroblocks
i=imread('E:\\Idaten\matlab\test.jpg');
a_=16;
b_=16;
a = []; b = [];
for k=1:120
    a = [a a_];
    b = [b b_];
end
g=mat2cell(i,a,b,3);
imshow(g{50,50});
r = g{50,50};
m = dec2hex(r);

%creating mem files
fid=fopen('mb_refvalues.txt','w');
fprintf(fid, [cell2mat(List)  '\n']);

