% Create SEDeeNN1 networks
% Architecture == 1: no constraints; full diversity allowed.
% Architecture == 2: semi-constrained; only one WF/NF allowed per layer
% Architecture == 3: constrained; only one WF/NF combination allowed for
% the whole network
function [net funcStat] = createNetEDeeNN1(limits,aSolRaw)


if limits.architecture == 1
    [net funcStat] = createEDeeNN1archit1(limits,aSolRaw);
elseif limits.architecture == 2
    [net funcStat] = createEDeeNN1archit2(limits,aSolRaw);
elseif limits.architecture == 3
    [net funcStat] = createEDeeNN1archit3(limits,aSolRaw);
else
    net = 0; funcstat = 1;
    disp(['Architecture ' int2str(limits.architecture) ' has not been specified yet.']);
end

% **** Some other useful information
% Type of architecture
net.architecture = limits.architecture;
% Number of layers
net.numNodeLayers = size(limits.numNodes,2);
% Number of parameters per weight layer
net.numParamPerLayer = compAllNumEDeeNNperLayer(limits);





