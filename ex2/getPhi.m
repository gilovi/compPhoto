function [ phi ] = getPhi( logLuminanceImage, method, params)
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
            if length(params) < 3
                error(['not enough params for method ' method ]);
            end
            f = @energy;

        otherwise
            error('given method is unsupported');
    end 

    
    %'d is chosen such that the width and the heigh of H d are at least 32':
    d = floor(min(log2(size(logLuminanceImage)/32)));
    %smallest pyrmid image & its phi:
    [mag,~] = imgradient(imresize(logLuminanceImage ,(0.5)^(d),'bilinear'),'CentralDifference');
    phi = f( mag, params);
    %iteratively sum phi:
    for i = d-1 : -1 : 0
        [mag,~] = imgradient(imresize(logLuminanceImage ,(0.5)^(i),'bilinear'),'CentralDifference');
        currLevel = f(mag, params);
        phi = imresize(phi, size(mag), 'bilinear' ) .* currLevel;
    end
    
    
    
%     phi = f( dhPyr{length(dhPyr)},params);
%     for i = (length(dhPyr)-1) : -1 : 1
%         currLevel = f(dhPyr{i}, params);
%         phi = imresize(phi, size(dhPyr{i}), 'bilinear' ) .* currLevel;
%     end
    

    

end

function attenuatuation = fattal(nablaHmag, params)
    alfaFac = params(1);
    beta = params(2);
    
    alfa = mean(nablaHmag(:)) .* alfaFac;
	nablaHmag(nablaHmag<=0) = eps('single');
    attenuatuation = (nablaHmag ./ alfa) .^ (beta - 1);
end

function attenuatuation = energy(nablaHmag, params)
%
% usage:  energy(nablaH, [mag,sigma,attenuation])
%   mag is the gaussian size, sigma is the gaussian sigma and attenuation is the attenuation factor 
    mag = params(1);
    sigma = params(2);
    att = params(3);

    h = fspecial('gaussian', floor(min(size(nablaHmag)/mag)), sigma);
    lowpass = (imfilter(nablaHmag, h,'same'));
    %figure;imshow(lowpass)
    %figure;hipass =  nablaHmag - lowpass;
    imshow(hipass)
    attenuatuation = (lowpass/att)+(hipass);
    %figure;imshow(attenuatuation);

end
