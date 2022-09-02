% Compute the accuracy for the Iris dataset
function [error errPat maxOutPat] = compIrisErrPat2(net,data)

% Get number of patterns
numPat = size(data.in,1);
% Initializations
maxOutPat = zeros(1,numPat);
% Scan through patterns
numCorrect = 0;
errPat = zeros(1,numPat);
for pi=1:numPat
    % Compute network output
    [netOut postNetKPH2 funcStat activHist] = runKPH2(data.in(pi,:),net);
    % Compute max node
    [netMaxVal netIndex] = max(netOut);
    maxOutPat(pi) = netIndex;
    % Compute Eucclidean Distance to target
    aDist = computeError2(netOut,data.out(pi,:));
    errPat(pi) = aDist;
end
% Compute percentage accuracy
error = mean(errPat);

end

