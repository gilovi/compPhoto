function [ dhPyr ] = getdH( logLuminanceImage )
%get_dH returns the dH pyramid for given log luminance image

    %'d is chosen such that the width and the heigh of H d are at least 32':
    d = floor(min(log2(size(logLuminanceImage)/32)));
    dhPyr = cell(1,d + 1);
    for i= 1 : (length(dhPyr) + 1)
        [mag,~] = imgradient(imresize(logLuminanceImage ,(0.5)^(i-1),'bilinear'),'CentralDifference');
        dhPyr{i} = mag;
    end
    
    
end

