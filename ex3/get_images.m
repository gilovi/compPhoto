function [imMat] = get_images(fileName, pathName)
%
    suffixless = fileName(1:regexp(fileName,'[0-9]+.*\..*')-1);
    
    srcFiles = dir(strcat(pathName,suffixless,'*'));
    imMat = cell(length(srcFiles),1);
    for i = 1 : length(srcFiles)
        imMat{i} = im2double(imread(strcat(pathName,filesep,srcFiles(i).name)));
    end
% tmp = zeros(size(imMat{1}));
% imMat = cell2mat(imMat);
% imMat = reshape(imMat,cat(2,size(tmp),length(srcFiles)));
    
end

