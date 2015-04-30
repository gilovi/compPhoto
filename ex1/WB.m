function [ WB_pic ] = WB( orig, flashed ,L2, method_num )
%WB generates White balanced picture from provided original,
%   flashed and gray card photos. 
%   the function will open a dialog for the user to mark the
%   gray card area in the gray_card picture and
%   works automatically since.
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
%           the white balanced piucture.
%
%   
%
    

orig = mat2gray(orig);
flashed = mat2gray(flashed);

% conversion matrices
brad = [.8951, .2664,-.1614;-.7502,1.7135,0.0367;0.0389,-0.0685,1.0296];
CIECAM02 = [.7328 .4296 -.1624; -.7036 1.6975 .0061; .0030 .0136 .9834];
von_kries = [0.38971 0.68898 -0.07868;-0.22981 1.1834 0.04641;0 0 1];
von_kries65 = [0.40024,0.7076,-0.0808100;-0.2263,1.16532,0.0457;0,0,0.91822]; %D65
xyz = eye(3);

switch method_num %picts in XYZ
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
        
    otherwise %picts in rgb
        M = eye(3);
        xyz2lms = eye(3);
end

if method_num > 5
    L1 = get_light_source(xyz2rgb(flashed),xyz2rgb(orig),L2)
else %convert the light source to lms 
    L1 = xyz2lms * permute(rgb2xyz(permute(get_light_source(xyz2rgb(flashed),xyz2rgb(orig) , L2), [3 2 1]) ),[3 2 1]);
end

norm_mat = diag(1./L1);
orig_p = permute(orig,[3 1 2]);
orig_r = reshape(orig_p , [3, length(orig(:))/3]);
s = size(orig_p);clear orig_p;

WB_pic =  M\norm_mat * M * orig_r;
WB_pic = permute(reshape(WB_pic , s) , [2 3 1]);

% try to reconstruct the intensity of the light source
S = orig(:,:,1) + orig(:,:,2) + orig(:,:,3);
[val,pos] = max(S());
S =  WB_pic(:,:,1) + WB_pic(:,:,2) + WB_pic(:,:,3);

prop = val/(S(pos));
%WB_pic = WB_pic .* prop;

%G = orig(:,:,2);
%[val , pos] = max(G(:));
%G = WB_pic(:,:,2);
%prop = val/(G(pos) )

end

