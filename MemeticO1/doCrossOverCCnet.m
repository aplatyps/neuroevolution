% Basic cross-over operator
function coSols = doCrossOverCCnet(sols,memParams)

coSols = [];
numPat = memParams.numPat;

disp('[12/03/13] Network version of cross-over not implemented yet.');

% Scan through solutions
% for si=1:memParams.numCOSol
%     aCOSol = crossOverSolCC(sols(:,2+numPat:end),memParams);
%     errPat = ones(1,numPat);
%     coSols = [coSols; -1 errPat aCOSol];
% end



end

