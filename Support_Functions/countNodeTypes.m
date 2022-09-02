function [numI numM numO] = countNodeTypes(nodes)
% Initialize counters
numI = 0; numM = 0; numO = 0;
% Get number of nodes
numNodes = size(nodes,2);
% Scan through nodes, check types and count
for ni=1:numNodes
   if nodes{ni}.type == 1
       numI = numI + 1;
   elseif nodes{ni}.type == 2
       numM = numM + 1;
   else
       numO = numO + 1;
   end
end



end

