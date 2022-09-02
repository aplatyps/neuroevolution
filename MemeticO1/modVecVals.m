% Modify selected vector elements by val
function vec = modVecVals(vec,selElem,val)
numSel = size(selElem,2);
for ei=1:numSel
    vec(selElem(ei)) = val;
end


end

