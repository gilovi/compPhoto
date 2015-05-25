function [ output_args ] = compressDR( image, method , params)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

throwPercent = 3;
image = double(image);
logLumChan = getLogLuminance(image);

phi = getPhi(logLumChan, method, params );
[Gx Gy] = getG(logLumChan, phi);

I = solvePoison(Gx Gy);

newlum = exp(I);

% discarding a small percentage of the darkest and the brightest pixels
mx = max(newlum(:));
mn = min(newlum(:));
range = mx - mn;
throwOffset = throwPercent * range / 100;
newlum(newlum > mx - throwOffset ) = mx;
newlum(newlum < mn + throwOffset ) = mn;
% rescale
newlum = mat2gray(newlum);

end

