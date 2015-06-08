function [ logLuminance ] = getLogLuminance( luminance )
%
mn = min(luminance(:));
mx = max(luminance(:));

nluminance = (luminance - min(luminance(:))) / (max(luminance(:))) * 100;
logLuminance = log(nluminance + eps);


end

