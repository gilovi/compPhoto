function [ moved ] = move( images , flowVec , degrees, beta )
%MOVE
%   degrees 0 to 180
%   beta from -1 to 1

toFlip = (any(flowVec(flowVec > 0)) && degrees < 90) ||...
            (any(flowVec(flowVec < 0)) && degrees > 90);

    [r,c,v] = size(images{1});
    if toFlip
        images = flip(images);
        flowVec = flip(flowVec')';
        beta = -beta;  
    end
    if degrees > 90
        degrees = 180 - degrees;
       
    end
    flowVec = abs(flowVec);
    
    center = floor(((beta+1)/2) * (length(images)-1)) + 1; % normalizing beta to be in #images scale
    theta = degrees/180*-pi;
    
    cumflow = [0; abs(cumsum(flowVec))];
    translation = cumflow - cumflow(center);
    pixVal = tan(theta)*translation;
    pixVal = pixVal/max(cumflow) * -c + 1; %normalizing and setting the sign.
    pixVal = pixVal + (cumflow(center)/max(cumflow)) * c;
    
    if toFlip
        dist = conv(pixVal,[1,-1]) - conv(cumflow,[1,-1]);
    else 
        dist = conv(pixVal,[1,-1]) + conv(cumflow,[1,-1]);
    end
    
    dist(1) = 0;
    dist(length(dist)) = 0;
    dist = dist/2;
    

     moved = zeros(r, 0 , v); 
    
    
    for i = 1 : length(images) 
          cur = images{i};
          bg = (min( (max(pixVal(i) - dist(i), 1) ) , c));
          ed = (min( (max(pixVal(i) + dist(i+1), 1) ) , c));
          

          if bg < ed
            moved = cat(2,moved,cur(:, round(bg) : round(ed) , :) );
          end

    end


end 

