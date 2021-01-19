function [] = homework2( )
% This is a simple example to help you evaluate your clustering algo implementation. You should run your code several time and report the best
% result. The data contains a 400*101 matrix call X, in which the last
% column is the true label of the assignment, but you are not allowed to
% use this label in your implementation, the label is provided to help you
% evaluate your algorithm. 
%
%
% Please implement your clustering algorithm in the other file, mycluster.m. Have fun coding!

load('data.mat');
T = X(:,1:100); % true label of the assignment
label = X(:,101);

% bar 1->100
sum_acc = 0;
max_acc = 0;
min_acc = 100;
time = 40;

for i = 1 : time
    [class, miu_jc] = mycluster(T,4);  % num of cluster 4
    Acc = AccMeasure(label,class); % T true label, class-->idx
    sum_acc = sum_acc + Acc;
    % Find the max accuracy
    if Acc > max_acc
        max_acc = Acc;
    else
    % Find the min accuracy
        min_acc = Acc;
    end
end
avg_acc = sum_acc / time;

display(avg_acc);
display(max_acc);
display(min_acc);

end