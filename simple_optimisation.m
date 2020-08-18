%Coefficients of the Probability constraints
A = [[1 1 0 0 0 0 0 0 0];
    [-3 0 0.5 0 0 0 0 0 0];
    [0 0 0 -1 -1 0 0 0 0];
    [0 0 0 -4 -1 0.5 0 0 0];
    [0 0 0 0 0 0 3 0 -0.5];
    [0 0 0 0 0 0 4 1 -0.5];
    [1 0 0 1 0 0 0 0 0];
    [-3 0 0 0 0 0 0.5 0 0];
    [0 -1 0 0 -1 0 0 0 0];
    [0 -4 0 0 -1 0 0 0.5 0];
    [0 0 3 0 0 0 0 0 -0.5];
    [0 0 4 0 0 1 0 0 -0.5]];

%RHS of inequality
b =[0;0;0;0;0;0;0;0;0;0;0;0];

%Coefficients of the sum of Probabilities for an equality
Aeq= [1 1 1 1 1 1 1 1 1];

%RHS of equality
beq = [1];

%Total payoffs turned into -v 
f = -1.*[6 4 0 4 2 0 0 0 1];

% Lower bound vector
lb = [0 0 0 0 0 0 0 0 0];

% Upper bound vector
ub = [1 1 1 1 1 1 1 1 1];

%Vector of probabilities
[x,fval] = linprog(f, A, b, Aeq, beq, lb, ub);
