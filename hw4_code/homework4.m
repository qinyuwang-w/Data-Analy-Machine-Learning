function homework4
% This is the main function for homework 4
% You are asked to plugin your implementation for algorithm, the argument is the q



clear all;close all;

load sp500;

prob1 = algorithm(0.7);
prob1(end,1)
plot(prob1(:,1),'color','r');
hold on; 

prob2 = algorithm(0.9);
plot(prob2(:,1),'color','b');
prob2(end,1)
legend('q=0.7','q=0.9')
end