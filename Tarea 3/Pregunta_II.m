%% Now it is time to find the general equilibrium 
tic
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
figure(1)
plot(r_list, suply_points, r_list, demand_points)
xlabel('Assets')
ylabel('Interest rate')

%% b) lets find the equlibrim interest rate

r_e = BS(@(R) delta_market(R, N, T, alpha, ...
    states, rho, sigmamu, beta, sigma, A, tol, delta), 0.02, 0.045);

%% c) effects of sigma

sigmamu_list = linspace(0.1, 0.19, 10);
rlist = [];
iteration = 1;
for sigma_i = sigmamu_list
    r_e = BS(@(R) delta_market(R, N, T, alpha, ...
    states, rho, sigma_i, beta, sigma, A, tol, delta), 0.0001, 0.04);
    rlist = [rlist r_e];
    disp('*************************************************')
    disp(strcat('iteration ->', num2str(iteration), " ready"))
    disp('*************************************************')
    iteration = iteration + 1;
end

%% lets see how the uncertainty is affecting the interest rate 
figure(2)
plot(sigmamu_list, rlist)
title('Uncertainty effects in equilibrium')
ylabel('Interest Rate in equilibrium')
xlabel('Sigma')

%%
Assets_means = [];
Consuption_means = [];
Production = [];

for i = 1:length(rlist)
    [suply, demand, consuption_mean, Assets_mean, production] = ...
    market(rlist(i), N, T, alpha, states, rho, sigmamu_list(i),...
    beta, sigma, A, tol, delta);

    Assets_means = [Assets_means Assets_mean];
    Consuption_means = [Consuption_means consuption_mean];
    Production = [Production production];

end

%%
figure(3)
e_summary(Consuption_means, "Consumption")
figure(4)
e_summary(Assets_means, "Assets")
figure(5)
plot(sigmamu_list, Production)
xlabel('Sigma')
ylabel('Production')
title('Production/Sigma')
toc