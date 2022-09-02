## Neural Network and Genetic Algorithm Implementations

Genetic algorithm is a method for solving both constrained and unconstrained optimisation problems inspired by natural selection in biological evolution. It can be used as an optimisation method for artificial neural networks. There are three key components to a genetic algorithm: mutation, crossover and selection.

Genetic algorithm of with adaptive mutation, uniform cross-over and tournament selection is found to yield the best results in reducing cost.

NOTE:
The current implemented tournament selection in doCrossOver2.m is unstable and more prone to get nearby solutions due to MATLAB function randi() returns uniformly distributed pseudorandom integer, potentially stuck in a local minima. However, paired with a divergence operation such as adaptive mutation, the negative impact should be canceled out.

Bias caused by simplicity of the current implemented adaptive mutation, uniform cross-over and tournament selection can potentially be fixed with:
- setting population as 20% from all solutions and selected probabilistically (low cost solutions have higher chances of being selected), then compared among each other to get best solution from population;
- an operator that rejects selection if a duplicate is detected, and;
- a deterministic mutation rate dependent on the fitness of a solution being used instead of a constant value.


