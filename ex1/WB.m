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
       xyz2lms = eye(3); 
end
%convert the light source to lms (or leave it in method_num > 3 )
L1 = xyz2lms * get_light_source(flashed,orig,extAvgColor(gray_card));
L1m = 1./repmat(L1,size(orig(:,:,1)));



%h = vision.GammaCorrector(2.2,'Correction','Gamma');
%cNo=step(h,mat2gray(no));
%y = step(h,x);

end

