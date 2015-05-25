function [ logLuminance ] = getLogLuminance( image )
%

luminance = rgb2gray(double (image));
luminance = (luminance - min(luminance(:))) / (max(luminance(:)) - min(luminance(:)));
logLuminance = log(luminance + eps);


end

