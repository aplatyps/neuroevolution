function netErr = computeEDeeNN1Error(aNet,data)

% Extract basic information
numPatterns = size(data.in,1); % Number of patterns

% Initialization
accumErr = 0;

% Scan through patterns
for pati=1:numPatterns
    % Run pattern through KPH1 network
    [netOut postNet funcStat] = runNetEDeeNN1(data.in(pati,:),aNet);
    % Compute error
    anError = sqrt(sum((netOut-data.out(pati,:)).^2));
    accumErr = accumErr + anError;
end

netErr = accumErr / numPatterns;

end

