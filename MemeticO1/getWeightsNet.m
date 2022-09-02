function weightVec = getWeightsNet(net)
numCon = size(net.con,2);
weightVec = zeros(1,numCon);
for ci=1:numCon
   weightVec(ci) = net.con{ci}.weight; 
end


end

