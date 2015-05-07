function [ avgColor ] = extAvgColor( gray_card_img )
%extAvgColor extracts the avarage color from selected area
%   used for determining the flash RGB channels.
%   The function will open a dialog for the user to mark the
%   gray card area in the gray_card picture

gray_card_img = im2double(gray_card_img);

figure; imshow (gray_card_img);title('please select part of the gray card');
f = imrect(gca);
mask = createMask(f);
mask = imfill(mask,'holes');
close;

avgColor  = sum(sum(gray_card_img.*repmat(mask,1,1,3)))/sum(mask(:));
avgColor = avgColor(:);

end

