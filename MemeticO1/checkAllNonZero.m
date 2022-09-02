function allNonZero = checkAllNonZero(mat)
[yLeng xLeng] = size(mat);
for y=1:yLeng
    for x=1:xLeng
        if mat(y,x) == 0
            allNonZero = false;
            return
        end
    end
end

allNonZero = true;

end

