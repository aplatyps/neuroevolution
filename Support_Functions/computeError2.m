function anError = computeError2(netOut,dataVec)

anError = sqrt(sum(abs((netOut-dataVec)).^2));


end

