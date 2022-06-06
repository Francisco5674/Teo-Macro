%% Now it is time to find the general equilibrium 
clear;
clc;
% setting paramters
beta = 0.96;
sigma = 2;
rho = 0.96;
sigmamu = 0.12;
delta = 0.05;
alpha = 0.33;
r = 0.03;
w = 1;
states = 5;
A = linspace(0, 30, 1001);
tol = 0.01;
N = 10000;
T = 2000;

%% first i need a function to find de Assets suply 
[suply, demand, consuption_mean, production] = ...
    market(0.0303, N, T, alpha, states, rho, sigmamu,...
    beta, sigma, A, tol, delta);

%% a) now, we have a function that actually can simulate the market 
r_list = linspace(0.01, 0.1, 10);
demand_points = [];
suply_points = [];
for r_i = r_list
    [suply, demand, consuption_mean, production] = ...
    market(r_i, N, T, alpha, states, rho, sigmamu,...
    beta, sigma, A, tol, delta);
    demand_points = [demand_points demand];
    suply_points = [suply_points suply];
end
%%
plot(r_list, suply_points, r_list, demand_points)

%% b) lets find the equlibrim interest rate

r_e = BS(@(R) delta_market(R, N, T, alpha, ...
    states, rho, sigmamu, beta, sigma, A, tol, delta), 0.02, 0.045);

%% c) effects of sigma

sigmamu_list = linspace(0.1, 1.19, 10);
rlist = [];
iteration = 1;
for sigma_i = sigmamu_list
    r_e = BS(@(R) delta_market(R, N, T, alpha, ...
    states, rho, sigma_i, beta, sigma, A, tol, delta), 0.00001, 0.1);
    rlist = [rlist r_e];
    disp('*************************************************')
    disp(strcat('iteration ->', num2str(iteration), " ready"))
    disp('*************************************************')
    iteration = iteration + 1;
end

%%

%%
