function [ flow ] = optical_flow( imCell )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    converter = vision.ImageDataTypeConverter; 
    opticalFlow = vision.OpticalFlow('Method','Lucas-Kanade');
    %opticalFlow = vision.OpticalFlow('ReferenceFrameDelay', 1);
    opticalFlow.OutputValue = 'Horizontal and vertical components in complex form';
    flow = zeros(length(imCell)-1,1);
    
    im = rgb2gray(step(converter, imCell{1}));
    of = step(opticalFlow, im);
    for i = 2 : length(imCell)
        im = rgb2gray(step(converter, imCell{i}));
        of = step(opticalFlow, im);
        flow(i-1)= mean(real(of(of>1)));
        
    end
    
    if (any(flow < 0) && any(flow > 0))
    error('images are not correctly aligned')
    end

end
