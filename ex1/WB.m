function [ WB_pic ] = WB( orig, flashed ,L2, method_num )
%WB generates White balanced picture from provided original, flashed photos and the flash RGB values.
%
%   
%   usage:
%   WB( orig, flashed , extAvgColor(grayCard), method_num )
%
%
%   inputs: 
%           orig: the original picture in xyz format.
%           flashed: the picture with flash in xyz format.
%           L2: the light source vector of the flash IN RGB
%           light source in xyz format.
%           method_num: the method to preform the WB-
%
%           1- bradford.
%           2- another method from wiki -CIECAM02
%           3- von-kries.
%           4- von-kries with D65 correction   
%           5- xyz scaling.
%           6- rgb scaling.
%           
%   output:
%           the white balanced , gamma corrected (not scated) picture.
%
%   
%
    

orig = im2double(orig);
flashed = im2double(flashed);

% conversion matrices
brad = [.8951, .2664,-.1614;-.7502,1.7135,0.0367;0.0389,-0.0685,1.0296];
CIECAM02 = [.7328 .4296 -.1624; -.7036 1.6975 .0061; .0030 .0136 .9834];
von_kries = [0.38971 0.68898 -0.07868;-0.22981 1.1834 0.04641;0 0 1];
von_kries65 = [0.40024,0.7076,-0.0808100;-0.2263,1.16532,0.0457;0,0,0.91822]; %D65
xyz = eye(3);

% from the Internet. asumming input pictures are in SRGB-D65 format.
rgb2xyz = [0.4124564  0.3575761  0.1804375; 0.2126729  0.7151522  0.0721750; 0.0193339  0.1191920  0.9503041];
xyz2rgb = inv(rgb2xyz);

switch method_num 
    case 1
        M = brad;
        xyz2lms = brad;
    case 2
        M = CIECAM02;
        xyz2lms = CIECAM02;
    case 3
        xyz2lms = von_kries;
        M = von_kries;
    case 4
        xyz2lms = von_kries;
        M = von_kries65;
    case 5 
        M = xyz;
        xyz2lms = eye(3);
        
    otherwise 
        M = eye(3);
        xyz2lms = eye(3);
end

orig_p = permute(orig,[3 1 2]);
orig_r = reshape(orig_p , [3, length(orig(:))/3]);
s = size(orig_p);clear orig_p;

if method_num > 5 % in RGB
    L1 = get_light_source(orig, flashed,L2);
else %convert the light source to lms 
    L1 = xyz2lms * rgb2xyz * get_light_source(orig, flashed , L2);
    orig_r =  rgb2xyz * orig_r;
end

norm_mat = diag(1./L1);

WB_pic =  M\(norm_mat * M * orig_r); % this is the formula from the pdf

if method_num <= 5 %back 2 rgb
WB_pic = xyz2rgb * WB_pic;
end

WB_pic = permute(reshape(WB_pic , s) , [2 3 1]);



% try to reconstruct the intensity of the light source
S = orig(:,:,1) + orig(:,:,2) + orig(:,:,3);
[val,pos] = max(S());
S =  WB_pic(:,:,1) + WB_pic(:,:,2) + WB_pic(:,:,3);

prop = val/(S(pos));
%WB_pic = WB_pic .* prop;

H = vision.GammaCorrector(2.2,'Correction','gamma');
WB_pic = step(H,(WB_pic));
%G = orig(:,:,2);
%[val , pos] = max(G(:));
%G = WB_pic(:,:,2);
%prop = val/(G(pos) )

end

