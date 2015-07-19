function [imCell] = get_images(fileName, pathName)
%
    suffixless = fileName(1:regexp(fileName,'[0-9]+\..*')-1);
    
    srcFiles = dir(strcat(pathName,suffixless,'*'));
    imCell = cell(length(srcFiles),1);
    for i = 1 : length(srcFiles)
        imCell{i} = im2double(imread(strcat(pathName,filesep,srcFiles(i).name)));
    end


end

