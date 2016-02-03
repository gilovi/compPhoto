function [dx dy] = findTransformations(im, im2, k, filSize)

max = 5;
im=rgb2gray(im);
im2=rgb2gray(im2);
[pyr, fil] = GaussianPyramid(im, k, max);
[pyr2, fil2] = GaussianPyramid(im2, k, max);
s = [0 0];
minL = min(numel(pyr), numel(pyr2));
minl = min(minL, max);
sTag = [1000 10000];
G = fspecial('gaussian', [filSize filSize], k);
% filt = conv2([1 2 1], [1;2;1]);
%filt = filt / sum(filt(:));
for j = drange(minl: - 1:1)
s=s*2;
im1 = pyr{j};
im2 = pyr2{j};
im1 = imfilter(im1, G, 'same');
im2 = imfilter(im2, G, 'same');
[Ix, Iy] = imgradientxy(im2);
Ix = Ix(3:end-2, 3:end-2);
Iy = Iy(3:end-2, 3:end-2);
while (1)
% im3 = imtranslate(im1, s);
im3 = interp2(im1, (1:size(im1, 2))-s(1), (1:size(im1, 1))'-s(2));
%im3(isnan(im3)) = 0;
% im3 = conv2(im3, filt, 'same');
% im2 = conv2(im2, filt, 'same');
It = im2 - im3;
It = It(3:end-2, 3:end-2);
A = [sum(sum(Ix .^ 2)) sum(sum(Ix .* Iy)); sum(sum(Ix .* Iy)) sum(sum(Iy .^ 2))];
B = [-sum(sum(Ix .* It)) -sum(sum(Iy .* It))]';
sTag = linsolve(A, B);
sTag(isnan(sTag)) = 0;
s = s+(sTag');
if (abs(sTag(1)) < 0.0001 && abs(sTag(2)) < 0.0001)
break
end
end
dx = s(1);
dy = s(2);
end