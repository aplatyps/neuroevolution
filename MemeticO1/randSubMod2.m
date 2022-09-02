% Create a new solution by changing a subset of parameters randomly
% randSubMod2: selected parameters are given small random perturbations
function aSolParam = randSubMod2(aSolParam,selParam,gsoParams)
% Parameters
range = 0.2; %0.05;
% Basic information
numSubParam = size(selParam,2);
minVal = gsoParams.paramRange(1);
maxVal = gsoParams.paramRange(2);
% Loop through parameter subset
for pi=1:numSubParam
    % Create new value and assign
    randVal = (rand*range*2)-range;
    newVal = aSolParam(selParam(pi)) + randVal;
    % Check limits
    if newVal<minVal
        newVal=minVal;
    elseif newVal > maxVal
        newVal=maxVal;
    end
    aSolParam(selParam(pi)) = newVal;
      
end

end

