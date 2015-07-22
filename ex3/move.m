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
pixVal = pixVal/max(cumflow) * -r + 1; %normalizing and setting the sign.
pixVal = pixVal + (cumflow(center)/max(cumflow)) * r;
if isNeg
    pixVal = pixVal * -1;
end

posDist = conv(pixVal,[-1,1]);
posDist = posDist(2:length(posDist)-1)/2;
shiftDist = conv(cumflow,[-1,1]); 
shiftDist = conv(shiftDist,[-1,1])/2;

%%%%%%%%
figure;plot(pixVal, 1:length(translation) ,'-');
grid on; grid minor; hold on; axis([1,r,1,length(translation)]);
plot(pixVal , 1:length(translation),'or' );
%%%%%%%%


% y = tan(theta)*cumflow + beta;
% %[~,centerIm] = min (abs((((c-1)/2)+(direction*((c-1)/2))+1) - cumPixflow));
% %dist = min(center,length(images) - center );
% 
% fl = floor(cumPixflow);
% cl = ceil(cumPixflow);
% rem = cumPixflow - fl;



% TODO: restrict the pixval and translation to its limits 
moved = zeros(sum(posDist*2) + sum(shiftDist*2), c);
for i = 1 : length(images)
     cur = images{i};
%     %int part
%     ipart = cl(i):fl(i+1);
%     moved(ipart) = cur(ipart);
%     %merge reminders:
%     if i < length(images)
%         moved(:,cl(i+1),:) = cur(:,cl(i+1),:)*(rem(i+1));
end
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
