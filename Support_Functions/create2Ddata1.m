% Create a data set based on an image. Samples are randomly drawn. The
% image is assumed to be greyscale. If the pixel value > 127 then out = 1,
% else out = 0.
% Arguments
% image: image from which to extract data; assumed to be greyscale.
% xRange: range x points (input 2); e.g. [minX maxX] -> [0 1]
% yRange: range y points (input 1); e.g. [minY maxY] -> [0 1]
% numSamples: number of data samples to be randomly selected
function data = create2Ddata1(imageRGB,xRange,yRange,numSamples)
image = imageRGB(:,:,1);
% Extract basic information
[yLeng xLeng] = size(image);
xRat = (xRange(2)-xRange(1))/xLeng;
yRat = (yRange(2)-yRange(1))/yLeng;
% Initialize data
data.in = [];
data.out = [];
% Scan through samples
for si=1:numSamples
    % Select a point randomly
    xRand = ceil(rand*xLeng);
    yRand = ceil(rand*yLeng);
    % Creat and store data entry
    outVal = double(image(yRand,xRand))/255;
%     if image(yRand,xRand) > 127
%         outVal = 1;
%     else
%         outVal = 0;
%     end
    % Adjust coordinates
    in1 = yRange(1)+((yLeng-yRand)*yRat);
    in2 = xRange(1)+(xRand*xRat);
    data.in = [data.in; in1 in2];
    data.out = [data.out; outVal];
    data.net = [];
    data.limits = [];
    
end


end

