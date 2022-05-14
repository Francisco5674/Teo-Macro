%% Question III
clear; clc;

% parameters
T = 70;
b = 0.96;
sigma = 2;
delta = 0.1;
alpha = 1/3;
r = (1 - b)/b;
h = 11111111110;

% wage vector
wf = @(r) (1 - alpha)*(alpha/(r + delta))^(alpha/(1 -alpha));
w = wage(r, T, alpha, delta);

% creating my asets grill
A = linspace(-15,25, 1001);

%%
gvector = linspace(0, 0.01, 11);

Aset_matrix = [];
re_vector = [];

for gi = gvector
re = BS(@(r) Auxdelta(r, T, b, sigma, A, delta, alpha, h, gi),...
    0.01, 0.20);
re_vector = [re_vector re];
w = wage(re, T, alpha, delta);

[Copt, vopt, Aopt] = V(A, re, w, T, b, sigma, h);
Aoptp = circshift(Aopt, -1);
Copt = w + (1 + re)* Aopt - Aoptp; 
Aset_matrix = [Aset_matrix Aopt'];
end
%%
hold on
for i = 1:length(gvector)
txt = strcat("interest rate = ", num2str(re_vector(i)), ...
    " and g =", num2str(gvector(i)));
plot(1:T, Aset_matrix(:, i), "DisplayName",txt)
title("Assets")
legend show
end
hold off

%%
plot(gvector, re_vector);
title("g and equilibrium interest rate")
xlabel("g")
ylabel("re")

%%

function dif = Auxdelta(r, T, b, sigma, A, delta, alpha, h, g)
dif = AuxA(r, T, b, sigma, A, alpha, delta, h, g)...
    - AuxK(r, T, delta, alpha, g);
end

function Aux_A = AuxA(r, T, b, sigma, A, alpha, delta, h, g)
w = wage(r, T, alpha, delta);
[Copt, vopt, Aopt] = V(A, r, w, T, b, sigma, h);
Aoptp = circshift(Aopt, -1);
Aux_A = dot(Aoptp,mt(g, T));
end

function Aux_K = AuxK(r, T, delta, alpha, g)
L = dot(product(T),mt(g, T));
Aux_K = fisher(r, delta, alpha, L);
end

function w = wage(r, time, alpha, delta)
w = [];
for t = 1:time
aux1 = 40/(0.4*t*sqrt(2*pi));
aux2 = -(0.5)*((log(t) - log(32.5))/0.4)^2;
w(t) = aux1 * exp(aux2) + 0.4;
end
aux3 = (1 - alpha)*(alpha/(r + delta))^(alpha/(1 -alpha));
w = w*aux3;
end

function y = product(T)
y = [];
for t = 1:T
aux1 = 40/(0.4*(t + 1)*sqrt(2*pi));
aux2 = -(0.5)*((log(t + 1) - log(32.5))/0.4)^2;
productivity = aux1 * exp(aux2) + 0.4;
y = [y productivity];
end
end