% Actual output is avrg. of two network outputs
function [netErr errPat] = computeNetErrorMaxOut(net1,net2,data)

numPatterns = size(data.in,1);

% Scan through patterns
netErr = 0;
errPat = [];
for pati=1:numPatterns
    
    % Run pattern through nets
    [netOut1 postNetKPH2 funcStat activHist] = runKPH2(data.in(pati,:),net1);
    [netOut2 postNetKPH2 funcStat activHist] = runKPH2(data.in(pati,:),net2);
    netOut3 = max(netOut1,netOut2);
    % Compute error
    anError = computeError1(netOut3,data.out(pati,:));
    % Add to cost
    netErr = netErr + anError;
    errPat = [errPat anError];
end

netErr = netErr / numPatterns;


end

