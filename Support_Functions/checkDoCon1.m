% [CH] Function for layered KPH2 networks
function doCon = checkDoCon1(sourcei,targi,firstMiddle,firstOutput,layParam)

doCon = false;

if sourcei == targi
    return
end

if sourcei < firstMiddle && targi < firstOutput
    doCon = true;
elseif sourcei < firstOutput && sourcei >= firstMiddle && targi < firstOutput && targi >= firstMiddle && layParam.conMid2Mid % Middle to middle
    doCon = true;
%elseif sourcei >= firstOutput && targi < firstOutput && targi >= firstMiddle && layParam.conOut2Mid% Out to middle
%    doCon = true;
elseif sourcei <= firstMiddle && targi >= firstOutput && layParam.conIn2Out % In to out
    doCon = true;
elseif sourcei < firstOutput && sourcei >= firstMiddle && targi >= firstOutput % Middle to out
    doCon = true;
end


end
