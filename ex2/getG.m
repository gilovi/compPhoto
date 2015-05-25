function [ Gx, Gy ] = getG( luminance, phi )
%getG returns the attenuated matrix G

[nablaHx, nablaHy] = imgradientxy(luminance,'IntermediateDifference');

Gx = nablaHx .* phi;
Gy = nablaHy .* phi;

end

