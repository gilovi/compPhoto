function [pyr, filter] = GaussianPyramid(im, maxLevels, filterSize )
tmpArray = abs(pascal(filterSize,1));
filter = tmpArray(filterSize,:);
filter = (filter/sum(filter));
curr=im;
[w,h] = size(curr);
levels = ceil(log2(min(w,h)/16));
levels = min(levels,maxLevels);
pyr = cell(levels,1);
pyr{1} = curr;
for i=2:levels
blurred = imfilter(curr,filter,'symmetric');
blurred = imfilter(blurred,filter','symmetric');
next = blurred(1:2:end, 1:2:end);
curr = next;
pyr{i} = next;
end
end