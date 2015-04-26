function [ L1 ] = get_light_source( I1, I2 ,L2 )
%get_light_source returns the light source from a flash/no flash images and the flash source vector. 
%   inputs: 
%           I1 : the no flash image
%           I2 : the image using flash
%           L2 : the vector describing the rgb channels of the flash source
%
%   output:
%           L1 : the original image's I1 light sorce (up to a constant)
%
%   for ferther information refer to the document.

L2_m = permute(L2,[3,2,1]);
[r,c,~]= size(I1);
L2_m = repmat(L2_m,[r,c]);

L1k = I1.*L2_m./(I1-I2);

G = (L1k(:,:,2)./L1k(:,:,1));
B = L1k(:,:,3)./L1k(:,:,1);

G(isnan(G)) = 0;


L1 = [1,mean(G(~isnan(G)&~isinf(G))),mean(B(~isnan(B)&~isinf(B)))]';

end

