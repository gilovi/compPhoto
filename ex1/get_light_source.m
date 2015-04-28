function [ L1 ] = get_light_source( I1, I2 ,L2 )
%get_light_source returns the light source from a flash/no flash images and the flash source vector. 
%   inputs: 
%           I1 : the image using flash
%           I2 : the no flash image
%           L2 : the vector describing the channels of the flash source
%
%   output:
%           L1 : the original image's I1 light sorce (up to a constant)
%   
%   this function takes out the extreame values the flash only image I1-I2,
%   as trial to eliminate outliers.
%    
%   for ferther information refer to the document.

I1 = mat2gray(I1); I2 = mat2gray(I2);
% replicate the L2 to a matrix the sise of the image 

L2_m = permute(L2,[3,2,1]);
[r,c,~]= size(I1);
L2_m = repmat(L2_m,[r,c]);

flash_only = (I1-I2);

%try to eliminate outliers
%S = sum(flash_only,3);
%outliers = ((S < (max(S(:))* 0.2))) | (S > max(S(:))* 0.6);

outliers = ((flash_only < (max(flash_only(:))* 0.2))) | (flash_only > max(flash_only(:))* 0.6);
outliers = (outliers(:,:,1) | outliers(:,:,2) | outliers(:,:,3));

%
L1k = (I1.*L2_m./(flash_only)) - L2_m;

%L1k(isnan(L1k) | isinf(L1k)) = 0;
R = L1k(:,:,1);
G = L1k(:,:,2);
B = L1k(:,:,3);
L1 = cat(3,mean(R(~outliers)), mean(G(~outliers)) , mean(B(~outliers)) );

L1 = L1./L1(:,:,2);

end

