% Function for retrieving properties from a KPH2 network
% The same results are produced in both a cell structure and a vector
% Properties:
% - cost
% - number of iterations
% - number of used nodes
% - total number of nodes
% - proportion of used nodes
% - number of used connections
% - total number of possible connections
% - proportion of used connections
% - used-connections / used-nodes (avrg. con. per node)
% - number of weight function 1 (inner-product)
% - number of weight function 2 (Euclidean distance)
% - number of weight function 3 (HO product)
% - number of weight function 4 (HO subtractive variability)
% - number of weight function 5 (standard deviation)
% - number of weight function 6 (min)
% - number of weight function 7 (max)
% - number of node function 1 (identity)
% - number of node function 2 (sigmoid)
% - number of node function 3 (Gaussian)
function [propCell propVec] = getKPH2prop(net)

% Initializations
propVec = [];
% *** Properties
% - cost
propCell.cost = net.vecCosts(end);
propVec = [propVec propCell.cost];
% - number of iterations
propCell.numIterations = net.numIterations;
propVec = [propVec propCell.numIterations];
% - number of used nodes
[numUsedNodes totNodes] = getNumUsedNodesKPH2(net);
propCell.numUsedNodes = numUsedNodes(4);
propVec = [propVec numUsedNodes(4)];
% - total number of nodes
propCell.totNodes = totNodes;
propVec = [propVec totNodes];
% - proportion of used nodes
propNodesUsed2Tot = numUsedNodes(4)/totNodes;
propCell.propNodesUsed2Tot = propNodesUsed2Tot;
propVec = [propVec propNodesUsed2Tot];
% - number of used connections
[numUsedCon totCon] = getNumUsedConKPH2(net);
propCell.numUsedCon = numUsedCon;
propVec = [propVec numUsedCon];
% - total number of possible connections
propCell.totCon = totCon;
propVec = [propVec totCon];
% - proportion of used connections
propConUsed2Tot = numUsedCon/totCon;
propCell.propConUsed2Tot = propConUsed2Tot;
propVec = [propVec propConUsed2Tot];
% - used-connections / used-nodes (avrg. con. per node)
usedConNodeProp = numUsedCon/numUsedNodes(4);
propCell.usedConNodeProp = usedConNodeProp;
propVec = [propVec usedConNodeProp];
[numWFs numNFs] = getWFnNF(net);
propCell.weightFuncCount = numWFs;
propVec = [propVec numWFs];
propCell.nodeFuncCount = numNFs;
propVec = [propVec numNFs];

end

