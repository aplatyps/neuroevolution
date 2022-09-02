function [netErr errPat] = computeNetError(net,data)

numPatterns = size(data.in,1);

% Scan through patterns
netErr = 0;
errPat = [];
for pati=1:numPatterns
    
    % Run pattern through KPH1 network
    [netOut postNetKPH2 funcStat activHist] = runKPH2(data.in(pati,:),net);
    % Compute error
    anError = computeError1(netOut,data.out(pati,:));
    
  
    % Add to cost
    netErr = netErr + anError;
    errPat = [errPat anError];
end


netErr = netErr / numPatterns;



end

