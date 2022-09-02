function aNet = createOneRandNet()

% Num nodes
numNodes.I = 2;
numNodes.M = 4;
numNodes.O = 1;

% Limits
limits.numNodes = numNodes;
limits.maxIter = 5;
limits.P_minWB = -1;
limits.P_maxWB = 1;
limits.sig_minFP = 0.3;
limits.sig_maxFP = 3;
limits.gaus_minFP1 = 0.3; % Gaussian steepness
limits.gaus_maxFP1 = 3; % Gaussian steepness
limits.gaus_minFP2 = 0; % Gaussian top cut-off threshold [if min/max = 0/2 smooth & abrupt; if 1/2 only smooth]
limits.gaus_maxFP2 = 2; % % Gaussian top cut-off threshold
limits.allNodesExist = true; % if true: all nodes must exist
limits.allConExist = true; % if true: all connections must exist
limits.weightFunctions = [1 2 3 4 5 6 7]; %[1 2 3 4 5 6 7]; %[1 2 3 4 5]; which weight functions to select from
limits.nodeFunctions = [1 2 3]; % which node functions to select from
limits.inNoIn = true; % if true: inputs can't receive connections from the net.
limits.outNoOut = true; % if true: outputs can't send connections to the net.
limits.noIn2Out = true; % if true: no connections from inputs to outputs
limits.noMid2Mid = false; % if true: no lateral connections between middle nodes
limits.allWFpresent = false; % if true: all listed weight functions must be used

expectedNumParams = compExpectNumParamKPH3(numNodes.I,numNodes.M,numNodes.O);
randParam = rand(1,expectedNumParams);
aNet = createKPH2sol(numNodes,limits,randParam,[]);


end

