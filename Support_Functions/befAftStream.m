% Function for computing the number of nodes before/after streamlining and
% compiling the results in a table
function resTable = befAftStream(nets,data)
% Parameters
befAftThresh = 0.2;

% Get number of networks
numNets = size(nets,2);
% Initialize
resTable = zeros(numNets,2);
% Scan networks
for neti=1:numNets
    disp(['Processing network ' int2str(neti) ' ...']);
    % Streamline
    aftNet = streamlineKPH2(nets{neti},data,befAftThresh);
    % Compute & store before/after number of nodes
    [numUsed totNodes] = getNumUsedNodesKPH2(nets{neti});
    befNumNodes = numUsed(4);
    [numUsed totNodes] = getNumUsedNodesKPH2(aftNet);
    aftNumNodes = numUsed(4);
    resTable(neti,:) = [befNumNodes aftNumNodes];
end


end

