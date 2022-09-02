function expectedNumParams = compExpectNumParamKPH3(numI,numM,numO)

%expectedNumParams = (6*numM)+(5*numO)+((numM+numO)*(2*(numI+numM)))+1;

totNodes = numI+numM+numO;
expectedNumParams = (7*numI)+(7*numM)+(7*numO)+(totNodes*(2*totNodes))+1;


end

