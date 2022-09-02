% Compute the accuracy for the Iris dataset
function [error errPat] = compIrisErrPat1(net,data)

% Get number of patterns
numPat = size(data.in,1);
% Scan through patterns
numCorrect = 0;
errPat = zeros(1,numPat);
for pi=1:numPat
    % Compute network output
    [netOut postNetKPH2 funcStat activHist] = runKPH2(data.in(pi,:),net);
    % Compute index
    [netMaxVal netIndex] = max(netOut);
    % Compute target index
    [targMaxVal targIndex] = max(data.out(pi,:));
    % If correct increment numCorrect
    if netIndex == targIndex
        numCorrect = numCorrect + 1;
    else
        errPat(pi) = 1;
    end
end
% Compute percentage accuracy
accur = (numCorrect/numPat);
error = 1-accur;


end

