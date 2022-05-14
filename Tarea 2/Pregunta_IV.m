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

% wage vector
wf = @(r) (1 - alpha)*(alpha/(r + delta))^(alpha/(1 -alpha));
w = wage(r, T, alpha, delta);

% creating my asets grill
A = linspace(-15,25, 1001);

%%
[Copt, Aopt] = Vl(A,r,w,T,b,phi,h);

%%
plot(1:T, Aopt, 1:T, Copt, 1:T, w)
xlabel("T")
legend("Assets", "consuption", "Wage")

%%
nopt = 1 - phi*(w.^-1).*Copt;
plot(1:T,nopt);

%% Auxiliar functions

function delta = Auxdelta(r, w, T, b, sigma, A, delta, alpha, h)
delta = AuxA(r, w, T, b, sigma, A, h) - AuxK(r, T, delta, alpha);
end

function Aux_A = AuxA(r, w, T, b, sigma, A, h)
[~, Aopt] = V(A, r, w, T, b, sigma, h);
Aux_A = sum(Aopt(2:end))/T;
end

function Aux_K = AuxK(r, T, delta, alpha)
L = Laboral_suply(T);
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