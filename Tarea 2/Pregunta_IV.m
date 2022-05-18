%% Question II
clear;

% parameters
T = 70;
b = 0.96;
sigma = 2;
delta = 0.1;
alpha = 1/3;
r = (1 - b)/b;
h = 10000000000;
phi = 1.2;
g = 0;

% wage vector
wf = @(r) (1 - alpha)*(alpha/(r + delta))^(alpha/(1 -alpha));
w = wage(r, T, alpha, delta);

% creating my asets grill
A = linspace(-15,25, 1001);

%%
hvector = linspace(0, 9, 6);

Cons_matrix = [];
Aset_matrix = [];
nopt_matrix = [];
re_vector = [];

for hi = hvector

re = BS(@(r) Auxdelta(r, T, b, A, delta, alpha, phi, g, hi),...
    0, 0.2);
re_vector = [re_vector re];
we = wage(re, T, alpha, delta);

[~, Aopt] = Vl(A,re,we,T,b,phi,hi);

Aoptp = circshift(Aopt, -1);
Copt = (we + (1 + re)* Aopt - Aoptp)/(1+phi);
nopt = 1 - phi*(we.^-1).*Copt;

Cons_matrix = [Cons_matrix Copt'];
Aset_matrix = [Aset_matrix Aopt'];
nopt_matrix = [nopt_matrix nopt'];
end
%%
hold on
for i = 1:length(hvector)
txt = strcat("interest rate = ", num2str(re_vector(i)), ...
    " and h =", num2str(hvector(i)));
plot(1:T, Cons_matrix(:, i), "DisplayName",txt)
title("Consuption")
legend show
end
hold off

%%
hold on
for i = 1:length(hvector)
txt = strcat("interest rate = ", num2str(re_vector(i)), ...
    " and h =", num2str(hvector(i)));
plot(1:T, Aset_matrix(:, i), "DisplayName",txt)
title("Assets")
legend show
end
hold off

%%
hold on
for i = 1:length(hvector)
txt = strcat("interest rate = ", num2str(re_vector(i)), ...
    " and h =", num2str(hvector(i)));
plot(1:T, nopt_matrix(:, i), "DisplayName",txt)
title("Working time")
legend show
end
hold off

%% Consuption/income correlation
ci_corr = [];
for i = 1:length(hvector)
    ci_corr = [ci_corr corrp(Cons_matrix(:, i), we.*nopt_matrix(:,i)')];
end

plot(hvector, ci_corr);
title("Restriction effects in consuption income correlation")
xlabel("the bigger the number the less restricted")
ylabel("Cons Income Correlation")


%% Auxiliar functions

function dif = Auxdelta(r, T, b, A, delta, alpha, phi, g, h)

w = wage(r, T, alpha, delta);
[Copt, Aopt] = Vl(A,r,w,T,b,phi,h);
nopt = 1 - phi*(w.^-1).*Copt;
Aoptp = circshift(Aopt, -1);
Aux_A = dot(Aoptp,mt(g, T));

dif = Aux_A...
    - AuxK(r, T, delta, alpha, nopt, g);
end

function Aux_K = AuxK(r, T, delta, alpha, n, g)
L = dot(n,mt(g, T));
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