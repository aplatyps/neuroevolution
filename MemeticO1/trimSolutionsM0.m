% Trim the x% (of NG size) solutions that are sufficiently different from each other
% [21/02/13] This is the original trimming function from GSO1
function trimSol = trimSolutionsM0(solutions,gsoParams)
% Extract basic information
[yLeng xLeng] = size(solutions);
numSol = yLeng;
numPat = gsoParams.numPat;
startParam = 2+numPat;
% Determine number of solutions required
numReqSol = round(gsoParams.ngSize*gsoParams.percTrim);
if numReqSol < 1
    numReqSol = 1;
end
% If you are doing fitness sharing then use a simpler form of trimming
% Initialize trimSol (number of rows = 1).
trimSol = zeros(1,xLeng);

% Store first solution
seli = 1;
stori = 1;
curSol = solutions(seli,:);
trimSol(stori,:) = curSol;
% Scan through solutions
while stori < numReqSol & seli ~= -1
    % Get the next sufficiently different solution
    inc = firstDiffSol(curSol(1,startParam:end),solutions(seli+1:end,startParam:end),gsoParams.minDiffTrim);
    % If it exists store it
    if inc == -1
        seli = -1;
    else
        seli = seli + inc;
        stori = stori + 1;
        curSol = solutions(seli,:);
        trimSol(stori,:) = curSol;
    end
end

