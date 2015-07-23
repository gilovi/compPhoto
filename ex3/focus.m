function [ Im ] = focus( I, shiftVal, remOc )
%FOCUS Summary of this function goes here
%   Detailed explanation goes here

[s,~] = size(I);
[h,w,d]=size(I{1});
mid = ceil(s/2);
imArry=zeros(h,w,d,s);
steps = mid-s:s-mid;

for i=1:s
    imArry(:,:,:,i) = shiftIm(I{i},steps(i)*shiftVal);   
end
    if remOc 
    Im = median(imArry,4);
    else
    Im = mean(imArry,4);
    end
    
end
arrayfun(@(idx) norm(permute(a(:,idx,:),[3 1 2])), 1:size(a,2));

