% Compute the accuracy for the Iris dataset
function accur = compAbaloneAccur2(net,data)

% Correctness threshold
ct = 3; % distance bet. targ. and actual out must be <= ct for the actual output to be "correct"

% Get number of patterns
numPat = size(data.in,1);
% Scan through patterns
totDiff = 0;
for pi=1:numPat
    % Compute network output
    [netOut postNetKPH2 funcStat activHist] = runKPH2(data.in(pi,:),net);
    % Target - Actual
    %disp(['netout: ' num2str(netOut)]);
    aDiff = abs(netOut-data.out(pi));
    totDiff = totDiff + aDiff;
end
% Compute percentage accuracy
accur = (totDiff/numPat);


end

