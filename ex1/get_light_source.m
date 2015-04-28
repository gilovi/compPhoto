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

% replicate the L2 to a matrix the sise of the image 
L2_m = permute(L2,[3,2,1]);
[r,c,~]= size(I1);
L2_m = repmat(L2_m,[r,c]);

flash_only = (I1-I2);

%try to eliminate outliers
S = sum(flash_only,3);
outliers = ((S < (max(S(:))* 0.2))) | (S > max(S(:))* 0.6);

%L2_m(repmat(outliers,1,1,3)) = 0;

%
L1k = (I1.*L2_m./(flash_only)) - L2_m;

g = repmat(L1k(:,:,2),1,1,3);
L1n = L1k./g;
L1n(isnan(L1n) | isinf(L1n)) = 0;
%G = (L1k(:,:,2)./L1k(:,:,1));
%B = L1k(:,:,3)./L1k(:,:,1);
R = L1n(:,:,1);
B = L1n(:,:,3);
L1 = [mean(R(~outliers)), 1 , mean(B(~outliers)) ];

%L1 = [1,mean(G(~isnan(G)&~isinf(G))),mean(B(~isnan(B)&~isinf(B)))]';

end

