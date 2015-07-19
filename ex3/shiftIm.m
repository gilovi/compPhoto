function [ im] = shiftIm( im,val)
% get image and val and move the image by val pixels.
% val can be fraction (and linear interpulation is used)
    val
    if ceil(val) == floor(val)
        im = circshift(im,[0,val]);
        return
    else
        c = ceil(val);
        f = floor(val);
        frc = (c - val);
        im = circshift(im,[0,c])*frc + (1-frc)*circshift(im,[0,f]);
        return
    end
end