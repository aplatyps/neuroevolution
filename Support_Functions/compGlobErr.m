% Function for computing the error relative to a net and a data set
function error = compGlobErr(net,data)
% Get number of patterns
numPatterns = size(data.in,1);
% Scan through patterns
error = 0;
for pati=1:numPatterns
    % Run network with inputs
    [netOut postNetKPH2 funcStat activHist] = runKPH2(data.in(pati,:),net);
    % Compute error and accumulate
    anError = computeError1(netOut,data.out(pati,:));
    error = error + anError;
end

error = error / numPatterns;

end

