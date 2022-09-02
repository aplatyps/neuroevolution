% Simple individual learning
% Types:
% 1: random parameters
% 2: random variations
% 3: self-cross over
% 4: differential individual learning (simple)
% 5: differential individual learning (2nd sol - stochastic variation)
% 6: differential individual learning (keep adding veloc. until no improv.)
% 7: differential individual learning (simpler than 4; only follower eval.)
function [ilSols numEval] = doIndivLearn1Net(baseSols,memParams,data)

% Basic information
numPat = memParams.numPat;
thisNumSol = size(baseSols,1);
numParam = size(baseSols,2)-numPat-1;

% ----------------------------------
disp('[12/3/12] Network version of individual learning not implemented yet.');
ilSols = baseSols;
numEval = 0;
% ----------------------------------

% % Select solutions for individual learning
% %solInds = randperm(thisNumSol);
% solInds = 1:thisNumSol;
% numSub = memParams.ilNumSol;
% selSol = solInds(1:numSub);
% % Do simple individual learning
% 
% if memParams.ilType == 1
%     memParams.ilRandType = 1;
%     disp('IL1 is not extended for complementary classifications yet. Sorry.');
%     %[ilSols numEval] = indivLearn2(baseSols,selSol,memParams,data);
% elseif memParams.ilType == 2
%     memParams.ilRandType = 2;
%     disp('IL2 is not extended for complementary classifications yet. Sorry.');
%     %[ilSols numEval] = indivLearn2(baseSols,selSol,memParams,data);
% elseif memParams.ilType == 3
%     disp('IL3 is not extended for complementary classifications yet. Sorry.');
%     %[ilSols numEval] = indivLearn3(baseSols,selSol,memParams,data);
% elseif memParams.ilType == 4
%     [ilSols numEval] = indivLearn4(baseSols,selSol,memParams,data); % solutions include error patterns, for possible CC usage.
% elseif memParams.ilType == 5
%     disp('IL5 is not extended for complementary classifications yet. Sorry.');
%     %[ilSols numEval] = indivLearn5(baseSols,selSol,memParams,data);
% elseif memParams.ilType == 6
%     disp('IL6 is not extended for complementary classifications yet. Sorry.');
%     %[ilSols numEval] = indivLearn6(baseSols,selSol,memParams,data);
% elseif memParams.ilType == 7
%     disp('IL7 is not extended for complementary classifications yet. Sorry.');
%     %[ilSols numEval] = indivLearn7(baseSols,selSol,memParams,data);
% elseif memParams.ilType == 8
%     [ilSols numEval] = indivLearn8(baseSols,selSol,memParams,data);
% else
%     [ilSols numEval] = indivLearn4(baseSols,selSol,memParams,data);
% end
%         
%     
% ilSols = sortSolutionsCC(ilSols);

end

