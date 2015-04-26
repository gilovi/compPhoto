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
%           3- xyz scale
%           
%   output:
%           the white balanced piucture.
%
%   
%

brad = [.8951, .2664,-.1614;-.7502,1.7135,0.0367;0.0389,-0.0685,1.0296];
von_kries = [0.40024,0.7076,-0.0808100;-0.2263,1.16532,0.0457;0,0,0.91822];

if (method_num)

h = vision.GammaCorrector(2.2,'Correction','Gamma');
cNo=step(h,mat2gray(no));
y = step(h,x);

end

