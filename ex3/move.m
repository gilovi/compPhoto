function [ moved ] = move( images , flowVec , degrees, beta )
%MOVE
% degrees 0 to 180
% beta from -1 to 1
[r,c,v] = size(images{1});
if any(flowVec(flowVec < 0))
images = flip(images);
flowVec = -1*flip(flowVec);
end
center = floor(((beta+1)/2) * (length(images)-1)) + 1; % normalizing beta to be in #images scale
theta = degrees/180*-pi;
cumflow = [0; abs(cumsum(flowVec))];
translation = cumflow - cumflow(center);
pixVal = tan(theta)*translation;
pixVal = pixVal/max(cumflow) * -c + 1; %normalizing and setting the sign.
pixVal = pixVal + (cumflow(center)/max(cumflow)) * c;
% if isNeg
% pixVal = pixVal * -1;
% end
%%%%%%%%
% figure;plot(pixVal, 1:length(translation) ,'-');
% grid on; grid minor; hold on; axis([1,r,1,length(translation)]);
% plot(pixVal , 1:length(translation),'or' );
%%%%%%%%
valid = (pixVal >= 1 & pixVal <= c); %trim to valid values
cumflow = cumflow(valid);
pixVal = pixVal(valid);
images = images(valid);
flow = [0;flowVec];
flow = flow(valid);
dist = conv(pixVal,[1,-1]) + conv(cumflow,[1,-1]);
%dist = dist+ones(size(dist));
dist(1) = 0;
dist(length(dist)) = 0;
dist = dist/2;
% TODO: restrict the pixval and translation to its limits
moved = zeros(r, sum(ceil(dist*2)) , v);
%figure;imshow(moved);
if ~valid(1)
f = images{1};
moved = cat(2, f(:, 1 : round(pixVal(1)), :), moved);
%figure; imshow (f(:, 1 : round(pixVal(1)), :))
% figure;imshow(moved);
end
if ~valid(length(valid))
f = images{length(images)};
moved = cat(2, moved, f(:, round(pixVal(length(pixVal))) : size(f,2),: ));
%figure; imshow (f(:, round(pixVal(length(pixVal))) : size(f,1),: ))
%figure;imshow(moved);
end
for i = 2 : length(pixVal)-1 %TODO handle edges %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cur = images{i};
rPxDist = pixVal(i+1)-pixVal(i) ;
lPxDist = pixVal(i)-pixVal(i-1);
iPx = round(pixVal(i));
rPx = iPx - pixVal(i);
iL = floor(dist(i));
iR = ceil(dist(i+1));
rL = dist(i) - floor(dist(i) + (rPx*(rPx>0)) );
rR = dist(i+1) - floor(dist(i+1) + (-rPx*(rPx<0)));
moved(:, iPx-iL : iPx+iR, : ) = cur(:, iPx-iL : iPx+iR ,:);
%imshow(cur(:, iPx-iL : iPx+iR ,:))
%imshow(moved);
%merge reminders:
%tmp = moved;
%tmp2=cur;
%tmp(:, iPx - ceil(iL+rL), 1) = 1;
%tmp2( :, iPx - ceil(iL+rL), 1)=1;
%figure;imshow(tmp);
%figure;imshow(tmp2);
moved(:, iPx - ceil(iL+rL), :) = cur( :, iPx - ceil(iL+rL), :)*(1-rL);
moved( : ,iPx + ceil(iR+rR) , :) = cur(:, iPx + ceil( iR+rR), :)*(rR+~rR);
%figure;imshow(moved)
end
end 