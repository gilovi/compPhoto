function [ moved ] = move( images , flowVec , degrees, beta )
%MOVE
%   degrees 0 to 180
%   beta from -1 to 1

    [r,c] = size(images{1});
    isNeg = any(flowVec(flowVec < 0));
    center = floor(((beta+1)/2) * (length(images)-1)) + 1; % normalizing beta to be in #images scale
    theta = degrees/180*-pi;
    
    cumflow = [0; abs(cumsum(flowVec))];
    translation = cumflow - cumflow(center);
    pixVal = tan(theta)*translation;
    pixVal = pixVal/max(cumflow) * -r + 1; %normalizing and setting the sign.
    pixVal = pixVal + (cumflow(center)/max(cumflow)) * r;
    if isNeg
        pixVal = pixVal * -1;
    end

    % posDist = conv(pixVal,[-1,1]);
    % posDist(1) = 0;
    % posDist(length(posDist)) = 0;
    % posDist = posDist/2;
    % 
    % shiftDist = conv(cumflow,[-1,1]); 
    % shiftDist(1) = 0;
    % shiftDist(length(shiftDist)) = 0;
    % shiftDist = shiftDist/2;

    dist = conv(pixVal,[-1,1]) + conv(cumflow,[-1,1]);
    dist(1) = 0;
    dist(length(dist)) = 0;
    dist = dist/2;

    %%%%%%%%
    figure;plot(pixVal, 1:length(translation) ,'-');
    grid on; grid minor; hold on; axis([1,r,1,length(translation)]);
    plot(pixVal , 1:length(translation),'or' );
    %%%%%%%%
    
    % TODO: restrict the pixval and translation to its limits 
    
    moved = zeros(sum(ceil(dist*2)), c);
    for i = 1 : length(images)
         cur = images{i};
    %   Ldist = dist(i);
    %   Rdist = dist(i+1);
         iL = ceil(dist(i));
         iR = floor(dist(i+1)) ;
         rL = dist(i) - floor(dist(i));
         rR = dist(i+1) - floor(dist(i+1));

         moved(pixVal(i)-iL : pixVal(i)+iR ) = cur(pixVal(i)-iL : pixVal(i)+iR);
    %merge reminders:
         moved(pixVal(i) - ceil(iL+rL)) = cur(pixVal(i) - ceil(iL+rL))*(1-rL);
         moved(pixVal(i) + ceil(iR+rR)) = cur(pixVal(i) +  ceil(iR+rR))*(rR+~rR);
    end

end 
