% Randomize the parameters in an NDM network
function net = randomizeParamsNet(net,memParams)
% Extract basic information
numNodes = size(net.nodes,2);
numCon = size(net.con,2);
limits = net.limits;
% Initialize some relevant information
minVal = limits.P_minWB;
diff = limits.P_maxWB - minVal;
% Scan connections
for ci=1:numCon
    % Randomize
    net.con{ci}.weight = minVal+rand*diff;
end
% Scan nodes
for ni=1:numNodes
    % Randomize autoWeight and bias.
    net.nodes{ni}.autoWeight = minVal+rand*diff;
    net.nodes{ni}.bias = minVal+rand*diff;
    % Randomize funcParams;
    if (net.nodes{ni}.nodeFunction == 2) % Sigmoid; type 2; 1 param
        rVal = rand;
        net.nodes{ni}.funcParam = putInRange(rVal,limits.sig_minFP,limits.sig_maxFP);
    elseif (net.nodes{ni}.nodeFunction == 3) % Gaussian; type 3; 2 param
        rVals = rand(1,2);
        net.nodes{ni}.funcParam(1) = putInRange(rVals(1),limits.gaus_minFP1,limits.gaus_maxFP1);
        net.nodes{ni}.funcParam(2) = putInRange(rVals(2),limits.gaus_minFP2,limits.gaus_maxFP2);
    end
end

end

