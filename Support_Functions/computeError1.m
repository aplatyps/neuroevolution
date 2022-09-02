function anError = computeError1(netOut,dataVec)

anError = sum(abs(netOut-dataVec));


end

