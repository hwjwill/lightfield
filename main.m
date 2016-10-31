function [] = main(part, parameter)
% Part represents the part of each assignment. For part 1, parameter is the
% constant that multiple to displacement from 8,8'th picture. For part 2,
% parameter is the radius around picture 8,8 to be included in averaging

% Folder name is the folder that saves all pictures from Stanford Light
% Field Archive
folderName = 'rectified/';
files = strcat(folderName, '*.png');
fnames = dir(files);
picCount = size(fnames, 1);
route = strcat(folderName, fnames(1).name);
im = imread(route);
avg = zeros(size(im, 1), size(im, 2), 3);
if part == 1
    %% Part one: Depth Refocusing
    for a = 1:picCount
        route = strcat(folderName, fnames(a).name);
        im = double(imread(route));
        routeArray = strsplit(fnames(a).name, '_');
        y = str2double(routeArray(2));
        x = str2double(routeArray(3));
        im = circshift(im, [(8 - y) * parameter, (x - 8) * parameter]);
        avg = avg + im / picCount;
    end
    result = uint8(avg);
    filename = strcat(num2str(parameter), 'lego.png');
    imwrite(result, filename);
elseif part == 2
    %% Part two: Aperture Adjustment
    totalNum = (2 * parameter + 1) ^ 2;
    for a = 1:picCount
        route = strcat(folderName, fnames(a).name);
        im = double(imread(route));
        routeArray = strsplit(fnames(a).name, '_');
        y = str2double(routeArray(2));
        x = str2double(routeArray(3));
        if inBoundary(x, y, parameter)
            avg = avg + im / totalNum;
        end
    end
    result = uint8(avg);
    filename = strcat(num2str(parameter), 'legoApeature.png');
    imwrite(result, filename);
end
end

%% Helper functions
function [r] = inBoundary(x, y, r)
if x >= 8 - r && x <= 8 + r && y >= 8 - r && y <= 8 + r
    r = true;
else
    r = false;
end
end