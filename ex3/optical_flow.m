function [ flow ] = optical_flow( imCell )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    converter = vision.ImageDataTypeConverter; 
    opticalFlow = vision.OpticalFlow;
    flow = zeros(size(imCell));
    for i = 1 : length(flow)
        im = rgb2gray(step(converter, imCell{i}));
        of = step(opticalFlow, im);
        mean2(of)
    end

end

