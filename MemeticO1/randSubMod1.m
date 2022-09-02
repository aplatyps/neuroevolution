% Create a new solution by changing a subset of parameters randomly
% randSubMod1: selected parameters are given new random values
function aSolParam = randSubMod1(aSolParam,selParam,gsoParams)
% Basic information
numSubParam = size(selParam,2);
% Loop through parameter subset
for pi=1:numSubParam
    % Create new value and assign
    aVal = randValInRange(gsoParams.paramRange(1),gsoParams.paramRange(2));
    aSolParam(selParam(pi)) = aVal;
      
end




end

