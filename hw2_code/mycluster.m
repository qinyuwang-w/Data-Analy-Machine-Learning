function [ class, miu_jc ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired topics/clusters. 
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc.
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!

num_doc = size(bow,1);  % row
num_word = size(bow,2); % column
% num_cluster = K;
T_ij = bow; % 400x100

% ---------------parameters initialization--------------
gamma_ic = zeros(num_doc, K); % 400x4
% normalization, divided by column-sums
miu_jc = rand(num_word, K); % 400x4
miu_jc = miu_jc ./ repmat(sum(miu_jc),num_word,1);  % normalization
% pi_c non-neagive, sum up to 1
pi_c = ones(1, K) / K;

iter = 0;
while iter < 50
% EM algorithm:
% -----------------Expectation Step----------------------
    for i = 1:num_doc
        gamma_ic(i,:) = pi_c .* prod(miu_jc .^ repmat(T_ij(i,:)',1,K),1);
        gamma_ic(i,:) = gamma_ic(i,:) ./ sum(gamma_ic(i,:)); % normalization
    end
% -----------------Maximization Step---------------------
    miu_jc = (gamma_ic' * T_ij)' ./ (repmat(sum(miu_jc),num_word,1));
    pi_c = 1 / num_doc * sum(gamma_ic);
    iter = iter + 1;
end

[~, class] = max(gamma_ic, [], 2);% return the index--->cluster label

end