function [imMat] = get_images(fileName, pathName)
%
    suffixless = fileName(1:regexp(fileName,'[0-9]+.*\..*')-1);
    
    srcFiles = dir(strcat(pathName,suffixless,'*'));
    imMat = cell(length(srcFiles),1);
    
    f = 1;
    tmp = im2double(imread(strcat(pathName,filesep,srcFiles(1).name)));
    [val,idx]= max(size(tmp));
    if val > 1024
        f = 1024/size(tmp,idx);
    end
    imMat{1} = imresize(tmp,f);
    clear tmp;
    
    for i = 2 : length(srcFiles)
        imMat{i} = im2double(imread(strcat(pathName,filesep,srcFiles(i).name)));
        imMat{i} = imresize(imMat{i},f);
    end

    
end

