function vec2 = spliceOut(vec1,selElem)
if isempty(selElem)
    vec2 = vec1;
    return
end
vec1Leng = size(vec1,2);
numSplice = size(selElem,2);
vec2 = zeros(1,vec1Leng-numSplice);
% Mark
for seli=1:numSplice
    vec1(selElem(seli)) = -1;
end
% Delete
v2i=1;
for v1i=1:vec1Leng
    if vec1(v1i) ~= -1
        vec2(v2i) = vec1(v1i);
        v2i = v2i + 1;
    end
end

end

