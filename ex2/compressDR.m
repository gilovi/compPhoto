function [ compressed ] = compressDR( image, method , params)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

%the precentage of the lower and upper values to throw
THROWPERCNT = 3;

image = double(image);
%HSV = rgb2hsv(image);
%lum = HSV(:,:,3);
lum = rgb2gray(image); 

logLumChan = getLogLuminance(lum);

phi = getPhi(logLumChan, method, params );
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
% add the rest and back to rgb:
%HSV(:,:,3) = newlum;
%compressed = hsv2rgb(HSV);

compressed = (image./cat(3,lum,lum,lum)).* cat(3,newlum,newlum,newlum);
compressed = compressed.^(1/2.2);

end

