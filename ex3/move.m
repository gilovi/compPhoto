function [ moved ] = move( images , flowVec , theta, beta )
%MOVE
%   theta from 0 to -pi
%beta from -1 to 1

%picAmount = floor(floor(length(images)/2)/amount);
[r,c] = size(images{1});

q3 = theta<-pi/2;
isNeg = any(flowVec(flowVec < 0));

cumflow = [0; abs(cumsum(flowVec))];
center = floor(((beta+1)/2) * (length(images)-1)) + 1; % normalizing beta to be in #images scale

translation = cumflow - cumflow(center);
pixVal = tan(theta)*translation;
%[~,i] = max(abs(y));
pixVal = pixVal/max(cumflow) * -r; %normalizing and setting the sign. 
pixVal = (pixVal+q3*r)+ 1 ; %if we are in quarter 3, we want a decending graph
pixVal = pixVal + (cumflow(center)/max(cumflow)) * r;

if isNeg
    pixVal = pixVal * -1;
end
%dist = min(center,length(images) - center );
figure;plot(pixVal, 1:length(translation) ,'-');
grid on; hold on; axis([0,r,0,length(translation)]);
plot(pixVal , 1:length(translation),'x' );
% for i=1:length(cumflow)
%    plot(y,cumflow(i),'-'); 
% end
%cumPixflow = [1;(cumsum( flowVec*c/sum(flow)))];
end

% y = tan(theta)*cumflow + beta;
% %[~,centerIm] = min (abs((((c-1)/2)+(direction*((c-1)/2))+1) - cumPixflow));
% %dist = min(center,length(images) - center );
% 
% fl = floor(cumPixflow);
% cl = ceil(cumPixflow);
% rem = cumPixflow - fl;
% 
% %moved = zeros(r,c);
% for i = 1 : length(images)
%     cur = images{i};
%     %int part
%     ipart = cl(i):fl(i+1);
%     moved(ipart) = cur(ipart);
%     %merge reminders:
%     if i < length(images)
%         moved(:,cl(i+1),:) = cur(:,cl(i+1),:)*(rem(i+1));
%     end
%     
%     if rem(i) ~= 0
%       moved(:,fl(i),:) = moved(:,fl(i),:) + cur(:,fl(i),:)*(1-rem(i));
%     end
%     
% end
% 
% 
% end
% 
