function [ Im ] = focus( I, shiftVal, ocli )
%FOCUS Summary of this function goes here
%   Detailed explanation goes here


[l,~] = size(I);
[h,w,d]=size(I{1})
mid = ceil(l/2);
imArry=zeros(l,h,w,d);
figure;
%imshow(I{1});
steps = mid-l:l-mid;
Im= zeros(h,w,d);
%im = zeros(size(I{1}));
for i=1:l
    imArry(i,:,:,:)= shiftIm(I{i},steps(i)*shiftVal);
    if ocli==0
        Im=Im+imArry(i); 
    end
        %im = im + shiftIm(I{i},steps(i)*shiftVal);
end


if ocki==0
    Im=Im./l;
end
imshow(Im);
end

