% Check whether a vector exists in a matrix (assume vec is a row)
function vecExists = checkVecInMat(vec,mat,tolerance)

vecExists = false;

[vecYleng vecXleng] = size(vec);
[matYleng matXleng] = size(mat);

if matYleng == 0
    return
end

if vecXleng ~= matXleng
    disp('Vector and matrix dimension mismatch.');
    return
end

for ri=1:matYleng
    aDiff = vec-mat(ri,:);
    dist = sqrt(sum(aDiff.^2));
    if dist <= tolerance
        vecExists = true;
        return
    end
    
end



end

