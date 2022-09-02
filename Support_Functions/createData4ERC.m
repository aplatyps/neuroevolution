% Create a data set for evoRepCacity ...
function data = createData4ERC(param)

inData = [];
outData = [];

% Scan through patterns
for pi=1:param.numPat
    
    % Input pattern
    inVec = putInRangeVec(rand(1,param.numIn),param.inRange(1),param.inRange(2));
    vecExists = checkVecInMat(inVec,inData,0);
    while vecExists
        inVec = putInRangeVec(rand(1,param.numIn),param.inRange(1),param.inRange(2));
        vecExists = checkVecInMat(inVec,inData,0);
    end
    inData = [inData; inVec];
    
    % Output pattern
    outVec = putInRangeVec(rand(1,param.numOut),param.outRange(1),param.outRange(2));
    vecExists = checkVecInMat(outVec,outData,0);
    while vecExists
        outVec = putInRangeVec(rand(1,param.numOut),param.outRange(1),param.outRange(2));
        vecExists = checkVecInMat(outVec,outData,0);
    end
    outData = [outData; outVec];
      
end

data.in = inData;
data.out = outData;
data.net = [];

end

