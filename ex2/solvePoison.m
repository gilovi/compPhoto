function [ I ] = solvePoison( Gx, Gy )
%SOLVEPOISON Summary of this function goes here
%   Detailed explanation goes here
divG = sparse(double(imfilter(Gx, [-1 1 0],0) + imfilter(Gy, [-1 1 0]',0)));


end

