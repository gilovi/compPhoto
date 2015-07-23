function [ Im ] = focus( I, shiftVal, ocli )
%FOCUS Summary of this function goes here
%   Detailed explanation goes here


[l,~] = size(I);
[h,w,d]=size(I{1});
mid = ceil(l/2);
imArry=zeros(l,h,w,d);
%figure;
%imshow(I{1});
steps = mid-l:l-mid;
Im= zeros(h,w,d);
tmp= zeros(h,w,d);

%imshow(shiftIm(I{1},steps(1)*shiftVal));
%imshowpair(shiftIm(I{1},steps(1)*shiftVal),I{1},'diff');
%im = zeros(size(I{1}));
for i=1:l
    %imArry(i,:,:,:)= shiftIm(I{i},steps(i)*shiftVal);
    tmp= shiftIm(I{i},steps(i)*shiftVal);
    %rt=size(imArry);
    %rt
    %size(imArry(i,:,:,:))
    imArry(i,:,:,:)=tmp;
    if ocli==0
        Im=Im+tmp; 
    end
        %im = im + shiftIm(I{i},steps(i)*shiftVal);
    %Im=Im+shiftIm(I{i},steps(i)*shiftVal);
end




if ocli==0
    Im=Im./l;
    size(Im)
else
    %b=permute(imArry,[4,1,2,3]);
    %x=reshape(b,l,numel(b)/l);
    %y=mean(x);
    %x=reshape(y,1,h,w,d);
    %aw=size(x);
    %Im=permute(x,[2,3,4,1]);
    Im=median(imArry,1);
    %Im=remat(Im(,:,:,:));
    size(Im)
end
%imshowpair(I{1},Im,'diff');
%imshow(Im);
end

