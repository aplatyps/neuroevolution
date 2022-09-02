function [numZeroes numOnes] = countZeroesOnes(vec)

% Initialize counters
numZeroes = 0;
numOnes = 0;
% Get vector length
vecLeng = max(size(vec));
% Scan through vector
for vi=1:vecLeng
    % Count
    if vec(vi) == 0
        numZeroes = numZeroes + 1;
    else
        numOnes = numOnes + 1;
    end
end

end

