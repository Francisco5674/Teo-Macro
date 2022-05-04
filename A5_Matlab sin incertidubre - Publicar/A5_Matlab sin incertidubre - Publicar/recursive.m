% ill try something imposible, wihs me luck

% solving the consumer problem with recursion 

%% Deudas en el ciclo de vida - item (a)
clc; clear; close all;

%Parameters
T =65; 
beta = 0.96; 
sigma = 2; 
r = 0.04; 
liq = 100;
A = linspace(-15,25,1001)';

% Wage as function and vector
Z  = @(t) 1.25 + 6e-2*t - 1e-3*t.^2;
w = Z(1:T);
w_mean = mean(w)*ones(1,T);

