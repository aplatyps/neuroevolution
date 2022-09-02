% Create Kernel Projection Higher-Order 2 (KPH2) network
% Notes: weights (i.e. [0,1]) are interpreted according to the weight function (e.g. [-1,+1]).
% ------ Arguments
% pattern: pattern for input neurons
% nodesKPH2: KPH2 nodes
% conKPH2: KPH2 connections
% ------ Some attributes of nodesKPH2
% ------ Types
% 1 - input node
% 2 - middle node (interneuron)
% 3 - output node
% ------ Weight functions
% 1 - inner product -> 'ipWF1'
% 2 - Euclidean distance -> 'edWF1'
% 3 - Higher-order (HO) product 1 -> 'hoWF1'
% 4 - Higher-order (HO) product 2 (standard) -> 'hoWF2'
% 5 - Standard deviation -> 'sdWF1'
% 6 - MIN -> 'minWF1'
% 7 - MAX -> 'maxWF1'
% ------ Node functions
% 1 - identity -> 'idNF'
% 2 - sigmoid -> 'sigNF1'
% 3 - Gaussian -> gausNF1'
% ------ Node status
% 0 - does not exist
% 1 - exists
% ------ Function status
% 0 - no error
% 1 - error
function [out net funcStat] = runNetEDeeNN1(pattern,net)


funcStat = 1;
out = [];
% Extract basic information
nodes = net.nodes;
numLayers = size(nodes,2);
numInputs = size(net.nodes{1},2);
lengPat = size(pattern,2);


% Basic initializations
out = [];
% Check pattern and input size compatibility
if lengPat ~= numInputs
    disp('The size of the pattern and the number of input neurons is different.');
    return
end

% Copy data to inputs
for ii=1:numInputs
    nodes{1}{ii}.value = pattern(ii);
end
% Scan layers
for li=2:numLayers
    aNumNodes = size(nodes{li},2);
    for ni=1:aNumNodes
        thisNode = nodes{li}{ni};
        inputValues = getValues(nodes{li-1});
        wfVal = feval(thisNode.weightFunction, inputValues, thisNode.conWeights,thisNode.bias);
        nfVal = feval(thisNode.nodeFunction,wfVal,thisNode.funcParam);
        nodes{li}{ni}.value = nfVal;
    end
end

% Package results
net.nodes = nodes;
out = getValues(nodes{numLayers});
funcStat = 0;

end



