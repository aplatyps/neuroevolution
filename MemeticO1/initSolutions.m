% Function for generating initial solution set
% The leftmost column is for holding solution costs (evaluations) ("-1" means "not defined")
% --- Arguments
% - gsoParams: global stochastic optimization parameters
function solutions = initSolutions(gsoParams)

solutions = feval(gsoParams.initSolFunc,gsoParams);

% if strcmp(gsoParams.initSolFunc,'initSolRand')
%    solutions = initSolRand(gsoParams);
% else
%    solutions = feval(gsoParams.initSolFunc);
% end





