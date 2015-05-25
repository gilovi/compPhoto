function [ field ] = gradientField( image )
%gradientField computes the given image's log-luminance channel gradientField
% gradient fields forever.

luminance = rgb2gray(double (image));
luminance = (luminance - min(luminance(:))) / (max(luminance(:)) - min(luminance(:)));

logLuminance = log(luminance + eps);


end

