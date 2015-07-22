function [ moved ] = move( images , flowVec , degrees, beta )
%MOVE
%   degrees 0 to 180
%   beta from -1 to 1

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
    pixVal = pixVal/max(cumflow) * -r + 1; %normalizing and setting the sign.
    pixVal = pixVal + (cumflow(center)/max(cumflow)) * r;

%     if isNeg
%         pixVal = pixVal * -1;
%     end
    %%%%%%%%
    figure;plot(pixVal, 1:length(translation) ,'-');
    grid on; grid minor; hold on; axis([1,r,1,length(translation)]);
    plot(pixVal , 1:length(translation),'or' );
    %%%%%%%%
    valid = (pixVal >= 1 & pixVal <= r); %trim to valid values 
    cumflow = cumflow(valid);
    pixVal = pixVal(valid); 
    images = images(valid);
    
    dist = conv(pixVal,[-1,1]) + conv(cumflow,[-1,1]);
    dist(1) = 0;
    dist(length(dist)) = 0;
    dist = dist/2;

    
    
    % TODO: restrict the pixval and translation to its limits 
    
    moved = zeros(sum(ceil(dist*2)), c , v);
    
    if ~valid(0)
        
    end
    for i = 1 : length(pixVal)
         cur = images{i};
    %   Ldist = dist(i);
    %   Rdist = dist(i+1);
         iPx = round(pixVal(i));
         rPx = iPx - pixVal(i);
         iL = ceil(dist(i));
         iR = floor(dist(i+1)) ;
         rL = dist(i) - floor(dist(i) + (rPx*(rPx>0)) );
         rR = dist(i+1) - floor(dist(i+1) + (-rPx*(rPx<0)));
         
         moved(iPx-iL : iPx+iR, : , : ) = cur(iPx-iL : iPx+iR ,: ,:);
    %merge reminders:
    
         moved(iPx - ceil(iL+rL), :, :) = cur(iPx - ceil(iL+rL), :, :)*(1-rL);
         moved(iPx + ceil(iR+rR) , : , :) = cur(iPx +  ceil(iR+rR), :, :)*(rR+~rR);
    end

end 
