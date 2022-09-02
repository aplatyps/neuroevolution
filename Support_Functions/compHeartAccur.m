% Compute the accuracy for the Heart dataset
function accur = compHeartAccur(net,data)

% Get number of patterns
numPat = size(data.in,1);
% Scan through patterns
numCorrect = 0;
for pi=1:numPat
    % Compute network output
    [netOut postNetKPH2 funcStat activHist] = runKPH2(data.in(pi,:),net);
    % Compute rounded value
    netRound = round(netOut);
    % Compute round target
    targRound = round(data.out(pi,:));
    % If correct increment numCorrect
    if netRound == targRound
        numCorrect = numCorrect + 1;
    end
end
% Compute percentage accuracy
accur = (numCorrect/numPat)*100;


end

