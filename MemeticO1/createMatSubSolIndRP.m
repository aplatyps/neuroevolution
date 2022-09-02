function mat = createMatSubSolIndRP(numPop, numSubSolPerPop)
mat = zeros(numSubSolPerPop,numPop);
for pi=1:numPop
    mat(:,pi) = randperm(numSubSolPerPop)';
end

end

