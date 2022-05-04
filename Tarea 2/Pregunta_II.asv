%% creating a new iterative algoritm with my style
clear; clc;

% parameters
T = 70;
b = 0.96;
sigma = 2;

% wage vector
wf = @(t) 1.5 + 5*10^(-2)*t - 10^(-3)*t.^2;
w = wf(1:T);
plot(1:T, w);

% creating my asets grill
A = linspace(-15,25, 1001);