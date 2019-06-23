% Sigmoid: Computes the sigmoid value at each of the 1-dimensional values in s
% s - Input samples
% t - Translation from the origin
% b - Beta parameter of the sigmoid function

function y=Sigmoid(s,t,b)

y=1./(1+exp(-b*(s-t)));
