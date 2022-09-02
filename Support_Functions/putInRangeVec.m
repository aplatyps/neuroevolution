% Function for normalizing parameters into specified ranges
function normParam = putInRangeVec(rawParam,minR,maxR)
% Vector length
[yLeng xLeng] = size(rawParam);
% Initialize output
normParam = zeros(yLeng,xLeng);
% Scan vector
for y=1:yLeng
    for x=1:xLeng
        % Put in range
        normParam(y,x) = putInRange(rawParam(y,x),minR,maxR);
    end
end

end

