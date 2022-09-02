% Trim the x% (of NG size) solutions that are sufficiently different from each other
% [21/02/13] This is the original trimming function from GSO1
function trimSol = trimSolutionsM0(solutions,memParams)
% Extract basic information
numSol = size(solutions,2);
numPat = memParams.numPat;
% Determine number of solutions required
numReqSol = round(memParams.ngSize*memParams.percTrim);
if numReqSol < 1
    numReqSol = 1;
end

% Store first solution
seli = 1;
stori = 1;
trimSol{1} = solutions{1};
curSol = solutions{1};
% Scan through solutions
while stori < numReqSol & seli ~= -1
    % Get the next sufficiently different solution
    inc = firstDiffSolNet(curSol,solutions(seli+1:end),memParams.minDiffTrim);
    %inc = firstDiffSol(curSol(1,2:end),solutions(seli+1:end,2:end),memParams.minDiffTrim); % error pattern + parameters
    %inc = firstDiffSol(curSol(1,2:2+numPat-1),solutions(seli+1:end,2:2+numPat-1),memParams.minDiffTrim); % error pattern
    %inc = firstDiffSol(curSol(1,:),solutions(seli+1:end,:),memParams.minDiffTrim);
    % If it exists store it
    if inc == -1
        seli = -1;
    else
        seli = seli + inc;
        stori = stori + 1;
        curSol = solutions{seli};
        trimSol{stori} = curSol;
    end
end

