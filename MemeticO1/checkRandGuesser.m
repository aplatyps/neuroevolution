function randGuesser = checkRandGuesser(errPat)


numOnes = length(find(errPat==1));
numZeros = length(find(errPat==0));

if numOnes == numZeros
    randGuesser = true;
else
    randGuesser = false;
end


end

