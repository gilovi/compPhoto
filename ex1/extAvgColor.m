function [ avgColor ] = extAvgColor( gray_card_img )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


figure; imshow (gray_card_img);title('please select part of the gray card');
f = imfreehand(gca);
mask = createMask(f);
close;

avgColor  = sum(sum(mat2gray(gray_card_img).*repmat(mask,1,1,3)))/sum(mask(:));
avgColor = avgColor(:);

end

