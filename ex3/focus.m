
function [ Im ] = focus( I, shiftVal, remOc )
%FOCUS Summary of this function goes here
%   Detailed explanation goes here

[s,~] = size(I);
[h,w,d]=size(I{1});
mid = ceil(s/2);
imArry=zeros(h,w,d,s);
steps = mid-s:s-mid;
M = zeros(w,s);
for i=1:s
    imArry(:,:,:,i) = shiftIm(I{i},steps(i)*shiftVal);   
end
    if remOc
%         Im=zeros(h,w,d);
%         for i=1:s
%             a = imArry(:,:,:,i);
%             M(:,i) = arrayfun(@(idx) norm(permute(a(:,idx,:),[3 1 2])), 1:size(a,2));
%         end
%         mn = mean(M,2);
%         for i=1:w
%            mat = M(i,:);
%            [~ ,p] = min(abs(mat-mn(i)));
%            tmp = imArry(:,i,:,p);
%            Im(:,i,:) = tmp;
%         end
        Im = median(imArry,4);
    else
        Im = mean(imArry,4);
    end
    
    
end

