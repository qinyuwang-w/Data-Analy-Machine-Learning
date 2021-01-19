function [ U, V ] = myRecommender( rateMatrix, lowRank )
    % Please type your name here:
    name = 'Qinyu Wang';
    disp(name); % Do not delete this line.

    % Parameters
    maxIter = 500; % Choose your own.
    learningRate = 0.00005; % Choose your own.
    regularizer = 0.5; % Choose your own.
    
    % Random initialization:
    [n1, n2] = size(rateMatrix);
    U = rand(n1, lowRank) / lowRank;
    V = rand(n2, lowRank) / lowRank;

    % Gradient Descent:
    iter = 0;
    limit = 0.001;
    err = 10;
    while (iter < maxIter && err > limit)
        u = U + 2*learningRate * ((rateMatrix - U*V' .* (rateMatrix>0)) *V - regularizer * U);
        v = V + 2*learningRate * ((rateMatrix - U*V' .* (rateMatrix>0))'*U - regularizer * V);
        U = u;
        V = v;
        err = sum(sum(rateMatrix - U*V' .* (rateMatrix>0)).^2) + regularizer * sum(sum(U.^2)) + regularizer * sum(sum(V.^2));
%         display(err);
        iter = iter + 1;
    end
    % IMPLEMENT YOUR CODE HERE.
end