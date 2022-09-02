% Compute the accuracy for the Iris dataset
function accur = compIrisAccur(net,data)

% Get number of patterns
numPat = size(data.in,1);
% Scan through patterns
numCorrect = 0;
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
    end
end
% Compute percentage accuracy
accur = (numCorrect/numPat)*100;


end

