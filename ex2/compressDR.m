function [ compressed ] = compressDR(image, method, params, gamma)
%compressDR Summary of this function goes here
%   Detailed explanation goes here

%the precentage of the lower and upper values to throw
THROWPERCNT = 0.2;

image = real(im2double(image));
HSV = im2double(rgb2hsv(image));
lum = HSV(:,:,3);

logLumChan = getLogLuminance(lum);
logHue = getLogLuminance (HSV(:,:,1));

phi = getPhi(logLumChan, method, params, logHue);

[Gx, Gy] = getG(logLumChan, phi);

I = solvePoison(Gx,Gy);

newlum = exp(I);

% discarding a small percentage of the darkest and the brightest pixels
mx = max(newlum(:));
mn = min(newlum(:));
range = mx - mn;
throwOffset = THROWPERCNT * range / 100;
newlum(newlum > mx - throwOffset ) = mx - throwOffset;
newlum(newlum < mn + throwOffset ) = mn + throwOffset;
% rescale
newlum = mat2gray(newlum);
% add the rest and back to hsv:
HSV(:,:,3) = newlum;
compressed = hsv2rgb(HSV);

compressed = compressed.^(1/gamma);

end

