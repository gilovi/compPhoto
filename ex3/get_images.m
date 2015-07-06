function [ imCell ] = get_images( path, fileName)
%UNTITLED Summary of this function goes here
%   fileName without suffix

    srcFiles = dir(strcat(path,filesep,fileName,'*'));
    imCell = cell(length(srcFiles),1);
    for i= 1 : length(srcFiles)

        imCell{i} = imread(strcat(path,filesep,srcFiles(i).name));
    end


end

