function [ WB_pic ] = WB( orig, flashed ,gray_card, method_num )
%WB generates White balanced picture from provided original,
%   flashed and gray card photos. 
%   the function will open a dialog for the user to mark the
%   gray card area in the gray_card picture and
%   works automatically since.
%
%   inputs: 
%           orig: the original picture in xyz format.
%           flashed: the picture with flash in xyz format.
%           geay_card: a picture with a grah card and only the flash as
%           light source in xyz format.
%           method_num: the method to preform the WB-
%           1- bradford.
%           2- von-kries.
%           3- xyz scale.
%           4- rgb scale.
%           
%   output:
%           the white balanced piucture.
%
%   
%
orig = mat2gray(orig);
flashed = mat2gray(flashed);
gray_card = mat2gray(gray_card);

brad = [.8951, .2664,-.1614;-.7502,1.7135,0.0367;0.0389,-0.0685,1.0296];
von_kries = [0.40024,0.7076,-0.0808100;-0.2263,1.16532,0.0457;0,0,0.91822];
xyz = eye(3);
xyz2lms = [0.3897 0.6889 -0.0786;-0.2298 1.1834 0.0464;0 0 1];

switch method_num
    case 1
        M = brad;
    case 2
        M = von_kries;
    case 3 
        M = xyz;
        
    otherwise
       M = xyz;
       xyz2lms = eye(3); 
end
%convert the light source to lms (or leave it in method_num > 3 )
L1 = xyz2lms * get_light_source(flashed,orig,extAvgColor(gray_card));

norm_mat = diag(1./L1);
orig_p = permute(orig,[3 1 2]);
orig_r = reshape(orig_p , [3, length(orig(:))/3]);
s = size(orig_p);clear orig_p;

WB_pic =  inv(M) * norm_mat * M * orig_r;
WB_pic = permute(reshape(WB_pic , s) , [2 3 1]);

% try to reconstruct the intensity of the light source
%S = orig(:,:,1) + orig(:,:,2) + orig(:,:,3);
%[val,pos] = max(S());
%S =  WB_pic(:,:,1) + WB_pic(:,:,2) + WB_pic(:,:,3);

%prop = val/(S(pos))
% WB_pic = WB_pic .* prop;

%G = orig(:,:,2);
%[val , pos] = max(G(:));
%G = WB_pic(:,:,2);
%prop = val/(G(pos) )

end

