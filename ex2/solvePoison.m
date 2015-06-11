function [ I ] = solvePoison( Gx, Gy )
%SOLVEPOISON Summary of this function goes here
%   Detailed explanation goes here
divG = sparse(double(imfilter(Gx, [-1 1 0],0) + imfilter(Gy, [-1 1 0]',0)));

[h,w] = size(Gx);
n = h*w;
mat = sparse(n,n);
ppDiag = [-2,ones(1,h-2)*(-3),-2];
midDiag = [-3,ones(1,h-2)*(-4), -3];
mainDiag = repmat(midDiag,1,w-2);
mainDiag = [ppDiag mainDiag ppDiag]';
subUpDiag = repmat([0,ones(1,h-1)],1,w)';
subLowDiag = repmat([ones(1,h-1),0],1,w)';

lapMat = spdiags(...
    [ones(n,1),subLowDiag,mainDiag,subUpDiag,ones(n,1)],...
    [-h,-1,0,1,h],mat);

I = lapMat\divG(:);
I = full(reshape(I,h,w));
I = I-min(I(:));

end

