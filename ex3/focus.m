function [ Im ] = focus( I, shiftVal, ocli )
%FOCUS Summary of this function goes here
%   Detailed explanation goes here


[l,~] = size(I);
l
[h,w,d]=size(I{1})
mid = ceil(l/2);
imArry=zeros(l,h,w,d);
figure;
%imshow(I{1});
steps = mid-l:l-mid;
Im= zeros(h,w,d);
%imshow(shiftIm(I{1},steps(1)*shiftVal));
%imshowpair(shiftIm(I{1},steps(1)*shiftVal),I{1},'diff');
%im = zeros(size(I{1}));
for i=1:l
    imArry(i,:,:,:)= shiftIm(I{i},steps(i)*shiftVal);
    %if ocli==0
        %Im=Im+imArry(i); 
    %end
        %im = im + shiftIm(I{i},steps(i)*shiftVal);
    Im=Im+shiftIm(I{i},steps(i)*shiftVal);
end

imshowpair(I{1},Im,'diff');
%if ocli==0
%    Im=Im./l;
%end
%imshow(Im);
end

