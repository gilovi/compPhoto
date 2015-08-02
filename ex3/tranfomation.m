
function [ T ] = tranfomation(imgs)

eps=0.1;

N = length(imgs);
T = zeros(N-1,1);
for j= 1:(N-1)
    
    I1 = rgb2gray(imgs{j});
    I2 = rgb2gray(imgs{j+1});
    id=eye(3);
    [pyr1, fil1] = GaussianPyramid(I1, 5, 3);
    [pyr2, fil2] = GaussianPyramid(I2, 5, 3);
    s = [0,0];
    filter = conv2([1 2 1], [1;2;1]);
    filter = filter / sum(filter(:));
    sl = [1000 1000];
    for i=length(fil1):-1:1
        s=2*s;
        I1 = pyr1{i};
        I2 = pyr2{i};
        Ix = conv2(I2, [1, 0, -1; 2, 0, -2; 1, 0, -1]/8, 'same');
        Iy = conv2(I2, [1, 2, 1; 0, 0, 0; -1, -2, -1]/8, 'same');
        Ix = Ix(3:end-2, 3:end-2);
        Iy = Iy(3:end-2, 3:end-2);
        while(abs(sl(1))>eps || abs(sl(2))>eps)
            I3=imtranslate(I1, s);
            I3(isnan(I3))=0;
            I3 = conv2(I3, filter, 'same');
            I2 = conv2(I2, filter, 'same');
            It = I2 - I3;
            It = It(3:end-2, 3:end-2);
            It(isnan(It)) = 0;
            A = [sum(sum(Ix.^2)), sum(sum(Ix.*Iy)); sum(sum(Ix.*Iy)), sum(sum(Iy.^2))];
            b = [-sum(sum(Ix.*(It))) , -sum(sum(Iy.*(It)))]';
            sl = linsolve(A,b);
            sl(isnan(sl))=0;
            s = s + sl';
        end
    end
     id(1,3)=s(1);
     id(2,3)=s(2);
     id=inv(id);
     T(j) = id(1,3);
end
end









