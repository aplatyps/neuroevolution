function errPats = errNormalize(errPats,minZeroErr)
[numSol numPat] = size(errPats);
for si=1:numSol
    for pi=1:numPat
        if errPats(si,pi) <= minZeroErr
            errPats(si,pi) = 0;
        else
            errPats(si,pi) = 1;
        end
    end
end



end

