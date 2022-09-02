% Create a data set based on an image. Samples are selected manually (mouse click). The
% image is assumed to be greyscale. If the pixel value > 127 then out = 1,
% else out = 0.
% *************************************************
% Mouse:
% - left click to select a sample
% - right click to quit
% *************************************************
% Arguments
% image: image from which to extract data; assumed to be greyscale.
% xRange: range x points (input 2); e.g. [minX maxX] -> [0 1]
% yRange: range y points (input 1); e.g. [minY maxY] -> [0 1]
function data = create2Ddata2(imageRGB,xRange,yRange)
image = imageRGB(:,:,1);
% Prepare figure
figure
imshow(image);
hold on
%drawnow;
% Extract basic information
[yLeng xLeng] = size(image);
xRat = (xRange(2)-xRange(1))/xLeng;
yRat = (yRange(2)-yRange(1))/yLeng;
% Initialize data
data.in = [];
data.out = [];
% Scan through samples
doQuit = false;
sampleIndex = 1;
while ~doQuit
    % Check mouse click
    % If left click, record coordinates and creat data entry
    % If right click, quit.
    
    
    [x y button] = ginput(1);
    %x
    %y
    
    if button == 1
        
        outVal = double(image(round(y),round(x)))/255;
        
%         if image(round(y),round(x)) > 127
%             outVal = 1;
%         else
%             outVal = 0;
%         end
        
        plot(x,y,'og');
        drawnow;
        in1 = yRange(1)+((yLeng-y)*yRat);
        in2 = xRange(1)+(x*xRat);
        data.in = [data.in; in1 in2];
        data.out = [data.out; outVal];
        data.net = [];
        data.limits = [];
        %data.in
        %data.out
        
    else
        doQuit = true;
    end
    
    
end


end

