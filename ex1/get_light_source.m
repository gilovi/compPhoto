function [ L1 ] = get_light_source( I2 , I1 ,L2 )
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
%flash_only(flash_only < 0) = 0;
avg = [mean(flash_only(:,:,1)) ,mean(flash_only(:,:,2)) ,mean(flash_only(:,:,3)) ];
Min = [min(flash_only(:,:,1)) , min(flash_only(:,:,2)), min(flash_only(:,:,3))];
Max = [max(flash_only(:,:,1)) , max(flash_only(:,:,2)), min(flash_only(:,:,3))];

% avg = [mean(flash_only(:,:,1)) ,mean(flash_only(:,:,2)) ,mean(flash_only(:,:,3)) ];
% Min = [min(min(flash_only(:,:,1))) , min(min(flash_only(:,:,2))), min(min(flash_only(:,:,3)))]
% Max = [max(flash_only(:,:,1)) , max(flash_only(:,:,2)), max(flash_only(:,:,3))];
% 
% 
% % outliers1 = flash_only < (avg - avg) ;
%  outliers1 =  flash_only(:,:,1) < (Min(1)) + (avg(1) - Min(1) )*.2  ;
%  outliers2 =  flash_only(:,:,2) < (Min(2)) + (avg(2) - Min(2) )*.2  ;
%  outliers3 =  flash_only(:,:,3) < (Min(3))+ (avg(3) - Min(3) )*.2  ;



% %outliers1 = flash_only < (avg - avg) ;
% outliers1 = flash_only < (Min + (avg - Min )*.01 ) ;
% outliers1 = (outliers1(:,:,1) | outliers1(:,:,2) | outliers1(:,:,3));
% % 
%  S = sum(flash_only,3);
%  outliers2 = S < max(S(:)* 0.8) ;
% % 
%  outliers3 = flash_only == max(flash_only(:)) ;
%  outliers3 = (outliers3(:,:,1) | outliers3(:,:,2) | outliers3(:,:,3));
% % 
outliers = outliers1;% | outliers2 | outliers3;

figure;imshow(outliers)
%
L1k = (I1.*L2_m./(flash_only)) - L2_m;

%L1k(isnan(L1k) | isinf(L1k)) = 0;
R = L1k(:,:,1);
G = L1k(:,:,2);
B = L1k(:,:,3);
L1 = [mean(R(~outliers)), mean(G(~outliers)) , mean(B(~outliers))]';

L1 = L1./L1(2);

end

