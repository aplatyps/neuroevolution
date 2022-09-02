function expectedNumParams = compExpectNumParamKPH2(numI,numM,numO)

%expectedNumParams = (6*numM)+(5*numO)+((numM+numO)*(2*(numI+numM)))+1;

totNodes = numI+numM+numO;
expectedNumParams = (6*numI)+(6*numM)+(6*numO)+(totNodes*(2*totNodes))+1;


end

