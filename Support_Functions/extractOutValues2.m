function out = extractOutValues2(netKPH2)
% Extract basic information
numI = netKPH2.numNodes.I;
numM = netKPH2.numNodes.M;
numO = netKPH2.numNodes.O;
firstOutput = numI+numM+1;
lastOutput = firstOutput+numO-1;
% Initialize out
out = zeros(1,numO);
% Scan output nodes and assign values
veci=1;
for oi=firstOutput:lastOutput
   out(veci) = netKPH2.nodes{oi}.value;
   veci=veci+1;
end


end

