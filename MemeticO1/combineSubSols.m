function aSol = combineSubSols(subIndeces,solutions)
numPop = size(subIndeces,2);
aSol = [];
for pi=1:numPop
   aSol = [aSol solutions{pi}(subIndeces(pi),:)];
end

end

