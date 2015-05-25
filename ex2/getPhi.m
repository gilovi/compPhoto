function [ phi ] = getPhi( dhPyr, method, params)
%getG returns an the attenuatuated log luminance channel matrix.
%  inputs: 
%       dhPyr: the log luminance channel pyrmid
%       method: the attenuatuation function. 'fattal' / energy
%       alfa ,beta : the attenuatuation parameters.
%
%   output:
%       The attenuatuated log luminance channel matrix G.

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
    
    
    phi = f( dhPyr{length(dhPyr)},params);
    for i = (length(dhPyr)-1) : -1 : 1
        currLevel = f(dhPyr{i}, params);
        phi = imresize(phi, size(dhPyr{i}), 'bilinear' ) .* currLevel;
    end
    

    

end

function attenuatuation = fattal(nablaH, params)
    alfaFac = params(1);
    beta = params(2);
    
    alfa = mean(nablaH(:)) .* alfaFac;
    attenuatuation = (im ./ alfa) .^ (beta - 1);
end

function attenuatuation = energy(nablaH, params)
%
% usage:  energy(nablaH, [mag,sigma,attenuation])
%   mag is the gaussian size, sigma is the gaussian sigma and attenuation is the attenuation factor 
    mag = params(1);
    sigma = params(2);
    att = params(3);

    h = fspecial('gaussian', floor(min(size(im)/mag)), sigma);
    lowpass=(imfilter(nablaH, h));
    hipass =  nablaH - lowpass;
    attenuatuation = (lowpass/att)+(hipass);

end
