function [ L1 ] = get_light_source( I2 , I1 ,L2 )
%get_light_source returns the light source from a flash/no flash images and the flash source vector. 
%   inputs: 
%           I2 : the original image
%           I1 : the image using flash
%           L2 : the vector describing the channels of the flash source
%
%   output:
%           L1 : the original image's I1 light sorce (up to a constant)
%   
%   this function takes out the extreame values the flash only image I1-I2,
%   as trial to eliminate outliers.
%    
%   for ferther information refer to the document.

I1 = im2double(I1); I2 = im2double(I2);
% replicate the L2 to a matrix the sise of the image 

L2_m = permute(L2,[3,2,1]);
[r,c,~]= size(I1);
L2_m = repmat(L2_m,[r,c]);

flash_only = (I1-I2);

%try to eliminate outliers
 figure;imshow(flash_only)

 outliers1 = (flash_only) <= 0 ;
 outliers1 = (outliers1(:,:,1) | outliers1(:,:,2) | outliers1(:,:,3));
 figure; imshow(outliers1)

 S = sum(flash_only,3);
 outliers2 = S < 0.07 ;
 figure;imshow(outliers2)

 outliers3 = mat2gray(flash_only) > 0.9 ;
 outliers3 = (outliers3(:,:,1) | outliers3(:,:,2) | outliers3(:,:,3));
 figure;imshow(outliers3)

 outliers = outliers1| outliers2 | outliers3;
 imshow(outliers)
%
L1k = (I1.*L2_m./(flash_only)) - L2_m;

%L1k(isnan(L1k) | isinf(L1k)) = 0;
R = L1k(:,:,1);
G = L1k(:,:,2);
B = L1k(:,:,3);
L1 = [mean(R(~outliers)), mean(G(~outliers)) , mean(B(~outliers))]';

L1 = L1./L1(2);

end

