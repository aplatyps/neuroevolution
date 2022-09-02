function [oneNonZero onzi] = checkOneNonZero(vec)
leng = max(size(vec));
numNonZero = 0;
oneNonZero = false;
onzi = -1;
for vi=1:leng
    if vec(vi) ~= 0
        onzi = vi;
        numNonZero = numNonZero + 1;
    end
    if numNonZero > 1
        onzi = -1;
        return
    end
end

if numNonZero == 1
    oneNonZero = true;
end
    

end

