function res = isInVec(val,vec)
vecLeng = max(size(vec));
res = false;
for vi=1:vecLeng
    if val == vec(vi)
        res = true;
        return
    end
end

end

