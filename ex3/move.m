function [ moved ] = move( images , flowVec , theta, beta )
%MOVE
%   theta from 0 to -pi
%beta from -1 to 1

%picAmount = floor(floor(length(images)/2)/amount);
[r,c] = size(images{1});

q = theta<-pi/2;
cumflow = [0;cumsum(flowVec)];
center = floor(((beta+1)/2) * (length(images)-1)) + 1;
x = cumflow - cumflow(center);
y = tan(theta)*x;%/ max(abs(x))*r);
[~,i] = max(abs(y));
y = y/max(abs(cumflow))*-r;
y = y+q*r;

%dist = min(center,length(images) - center );

%cumPixflow = [1;(cumsum( flowVec*c/sum(flow)))];

y = tan(theta)*cumflow + beta;
winSize = 
%[~,centerIm] = min (abs((((c-1)/2)+(direction*((c-1)/2))+1) - cumPixflow));
%dist = min(center,length(images) - center );

fl = floor(cumPixflow);
cl = ceil(cumPixflow);
rem = cumPixflow - fl;

%moved = zeros(r,c);
for i = 1 : length(images)
    cur = images{i};
    %int part
    ipart = cl(i):fl(i+1);
    moved(ipart) = cur(ipart);
    %merge reminders:
    if i < length(images)
        moved(:,cl(i+1),:) = cur(:,cl(i+1),:)*(rem(i+1));
    end
    
    if rem(i) ~= 0
      moved(:,fl(i),:) = moved(:,fl(i),:) + cur(:,fl(i),:)*(1-rem(i));
    end
    
end


end

