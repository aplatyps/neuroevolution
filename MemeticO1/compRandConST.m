function [rs rt] = compRandConST(numNodes)

choices = 1:numNodes;
randIndex = ceil(rand*numNodes);
if randIndex == 0
    randIndex = 1;
end
rs = choices(randIndex);
choices(randIndex) = [];
randIndex = ceil(rand*(numNodes-1));
if randIndex == 0
    randIndex = 1;
end
rt = choices(randIndex);
