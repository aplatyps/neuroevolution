function [nodesI nodesM nodesO] = sepNodesR1toR2(nodes,numI,numM,numO)

Ii1 = 1; Ii2 = numI;
Mi1 = Ii2+1; Mi2 = Ii2+numM;
Oi1 = Mi2+1;

nodesI = nodes(Ii1:Ii2);
nodesM = nodes(Mi1:Mi2);
nodesO = nodes(Oi1:end);


end

