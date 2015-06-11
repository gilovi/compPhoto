function [ phi ] = getPhi( logLuminanceImage, method, params ,hue)
%getG returns an the attenuation log luminance channel matrix.
%  inputs: 
%       dhPyr: the log luminance channel pyrmid
%       method: the attenuatuation function. 'fattal' / energy
%       alfa ,beta : the attenuatuation parameters.
%
%   output:
%       The attenuation log luminance channel matrix G.

    switch method
        case 'fattal'
            f = @fattal;
        case 'energy'
%             if length(params) < 3
%                 error(['not enough params for method ' method ]);
%             end
            f = @energy;

        otherwise
            error('given method is unsupported');
    end 

    
    %'d is chosen such that the width and the heigh of H d are at least 32':
    d = floor(min(log2(size(logLuminanceImage)/32)));
    %smallest pyrmid image & its phi:
    [mag,~] = imgradient(imresize(logLuminanceImage ,(0.5)^(d),'bilinear'),'CentralDifference');
    phi = f( mag, params , imresize(hue,(0.5)^(d)) );
    %iteratively sum phi:
    for i = d-1 : -1 : 0
        [mag,~] = imgradient(imresize(logLuminanceImage ,(0.5)^(i),'bilinear'),'CentralDifference');
        currLevel = f(mag, params, imresize(hue,(0.5)^(i)));
        phi = imresize(phi, size(mag), 'bilinear' ) .* currLevel;
    end
    
    
    
%     phi = f( dhPyr{length(dhPyr)},params);
%     for i = (length(dhPyr)-1) : -1 : 1
%         currLevel = f(dhPyr{i}, params);
%         phi = imresize(phi, size(dhPyr{i}), 'bilinear' ) .* currLevel;
%     end
    

    

end

function attenuatuation = fattal(nablaHmag, params, ~)
    alfaFac = params(1);
    beta = params(2);
    
    alfa = mean(nablaHmag(:)) .* alfaFac;
	nablaHmag(nablaHmag<=0) = eps('single');
    attenuatuation = (nablaHmag ./ alfa) .^ (beta - 1);
    
end

function attenuatuation = energy(nablaHmag, params ,hue)
%
hueProp = params(3);

[hueDer,~] = imgradient(hue,'intermediatedifference');
attenuatuation = fattal(nablaHmag, params ,hue) + (hueDer/hueProp);

end
