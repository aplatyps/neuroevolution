% Trim the x% (of NG size) solutions that are sufficiently different from each other
function trimSol = trimSolutions(solutions,gsoParams)
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
if gsoParams.ccMatrixTypeFS > 0
    trimSol = solutions(1:numReqSol,:);
else
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
        %inc = firstDiffSol(curSol(1,2:end),solutions(seli+1:end,2:end),gsoParams.minDiffTrim); % error pattern + parameters
        %inc = firstDiffSol(curSol(1,2:2+numPat-1),solutions(seli+1:end,2:2+numPat-1),gsoParams.minDiffTrim); % error pattern
        %inc = firstDiffSol(curSol(1,:),solutions(seli+1:end,:),gsoParams.minDiffTrim);
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
end

