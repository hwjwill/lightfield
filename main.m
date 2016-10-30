function [] = main()
part1 = true;
if part1
    %% Part one: Depth Refocusing
    fnames = dir('rectified/*.png');
    picCount = size(fnames, 1);
    route = strcat('rectified/', fnames(1).name);
    im = imread(route);
    %im = imresize(im, 0.25);
    c = -2;
    avg = zeros(size(im, 1), size(im, 2), 3);
    for a = 1:picCount
        route = strcat('rectified/', fnames(a).name);
        im = double(imread(route));
        %im = imresize(im, 0.25);
        routeArray = strsplit(fnames(a).name, '_');
        y = str2double(routeArray(2));
        x = -str2double(routeArray(3));
        im = circshift(im, [(8 - y) * c, (8 - x) * c]);
        avg = avg + im / picCount;
    end
    result = uint8(avg);
    filename = strcat(num2str(c), '.png');
    imwrite(result, filename);
    imshow(result);
else
    %% Part two: Aperture Adjustment
end
end