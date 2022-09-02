% Sort according to column
function sortMat = sortAccordCol(mat,colNum)

% Extract basic info
[yLeng xLeng] = size(mat);
% Initialize output
sortMat = zeros(yLeng,xLeng);

% Sort and get indeces
[vals inds] = sort(mat(:,colNum));

for ri=1:yLeng
    anIndex = inds(ri);
    sortMat(ri,:) = mat(anIndex,:);
end

end

