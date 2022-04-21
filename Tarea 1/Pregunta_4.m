%% Pregunta 4
clear;
clc;

%a)
% x0 es 1
% B es la sequencia sin perturbacion
B = points_xt(100, 0.9, 1, "", 1, [], 0);
% A es la secuencia con una perturbacion
A = points_xt(100, 0.9, 1, "", 1, 1, 1);

% creo que 500 puntos es algo excesivo, se aprecia mejor con 100 puntos
plot(1:length(A), A, 1:length(B), B);
title('Comparacion de las sequencias')
legend('Serie perturbada', 'Serie sin perturbar')

%% b) distintos phi
phis = [0.1 0.2 0.4 0.6 0.8 0.95];

figure();
subplot(3, 2, 1);
B1 = points_xt(100, phis(1), 1, "", 1, [], 0);
plot(B1);
title('phi = 0.1')
subplot(3, 2, 2);
B2 = points_xt(100, phis(2), 1, "", 1, [], 0);
plot(B2);
title('phi = 0.2')
subplot(3, 2, 3);
B3 = points_xt(100, phis(3), 1, "", 1, [], 0);
plot(B3);
title('phi = 0.4')
subplot(3, 2, 4);
B4 = points_xt(100, phis(4), 1, "", 1, [], 0);
plot(B4);
title('phi = 0.6')
subplot(3, 2, 5);
B5 = points_xt(100, phis(5), 1, "", 1, [], 0);
plot(B5);
title('phi = 0.8')
subplot(3, 2, 6);
B6 = points_xt(100, phis(6), 1, "", 1, [], 0);
plot(B6);
title('phi = 0.95')

%% c)
GDP = readtable('GDP.xlsx');
GDP = table2array(GDP);
x = 1:length(GDP);

%% d) HP filter
[c, s] = HP(GDP', 10);
figure();
plot(x, s, x, c, x, s + c, "--")
title("PIB per capita LCU")
legend("Tendencia", "Ciclo", "Serie original")

%% e)
% proceso AR1 en el PIB, como no existe un coeficiente de pos en un modelo
% de esta naturaleza, no optare por incluirlo
GDPC_x = circshift(c, 1);
GDPC_x(1) = [];
GDPC_y = c;
GDPC_y(1) = [];
% calculamos el regresor
beta = (GDPC_x'*GDPC_x)\GDPC_x'*GDPC_y;

%% f)

% B es la sequencia sin perturbacion
B = points_xt(60, beta, c(1), "", 1, [], 0);
% A es la secuencia con una perturbacion
A = points_xt(60, beta, c(1), "", 1, 1, 10^5);

figure();
plot(1:length(A), A, 1:length(B), B, 1:length(c), c);
title('Comparacion de las sequencias')
legend('Serie GDP perturbada', 'Serie GDP sin perturbar', 'Ciclo GDP per cap')

%% g)
% opté por gráficar con una perturbacion y una mayor persistencia

% B es la sequencia sin perturbacion
B = points_xt(60, beta, c(1), "", 1, [], 0);
% A es la secuencia con una perturbacion
A = points_xt(60, beta, c(1), "", 1, 1, 10^5);
A_v = points_xt(60, beta + 0.3, c(1), "", 1, 1, 10^5);

figure();
subplot(2, 1, 1)
plot(1:length(A), A, 1:length(B), B, 1:length(c), c);
title('Comparacion de las sequencias')
legend('Serie GDP perturbada', 'Serie GDP sin perturbar', 'Ciclo GDP per cap')

subplot(2, 1, 2)
plot(1:length(A_v), A_v, 1:length(B), B, 1:length(c), c);
title('Comparacion de las sequencias distinta peersistencia')
legend('Serie GDP perturbada', 'Serie GDP sin perturbar', 'Ciclo GDP per cap')

%% h)

% B es la sequencia sin perturbacion
B = points_xt(60, beta, c(1), "", 1, [], 0);
% A es la secuencia con una perturbacion
A = points_xt(60, beta, c(1), "", 1, 1, 10^5);
A_v = points_xt(60, beta, c(1), "", 1, [12 21 29 38 46 52], 2*10^5);

figure();
subplot(2, 1, 1)
plot(1:length(A), A, 1:length(B), B, 1:length(c), c);
title('Comparacion de las sequencias')
legend('Serie GDP perturbada', 'Serie GDP sin perturbar', 'Ciclo GDP per cap')
% opté por gráficar con una perturbacion y con varias en distitnos
% periodos. Notar que si escogemos adecuadamente el momento y la magnitud del shock 
% en el tiempo en el que poner los shocks y su magnitud, la serie y la 
% predicción se parecerían cada vez más.

subplot(2, 1, 2)
plot(1:length(A_v), A_v, 1:length(B), B, 1:length(c), c);
title('Comparacion de las sequencias distintas perturbaciones')
legend('Serie GDP perturbada', 'Serie GDP sin perturbar', 'Ciclo GDP per cap')

%% Functions

% el valor de eps_d y sd son la distribucion de las perturbaciones y sd es 
% la desviacion estandar

% t_p es un vector con los periodos que tienen perturbacion y p es el
% tamano de la perturbacion
function sim = points_xt(n, phi, x0, eps_d, sd, t_p, p)
sim = [];
sim(1) = x0;
for i = 2:n
    if ismember(i - 1, t_p)
        x = xt1(x0, phi, eps_d, sd) + p;
        sim(i) = x;
        x0 = x;
    else
        x = xt1(x0, phi, eps_d, sd);
        sim(i) = x;
        x0 = x;
    end
end
end

% la sequencia primero
function x = xt1(xt, phi, eps_d, sd)
if eps_d == "N"
    eps = randn(1)*sd;
    x = xt*phi + eps;
else
    x = xt*phi;
end
end

% funciones del filtro
function [c, s] = HP(y, lambda)
n = length(y);
A = MatrixA(n, lambda);
c = (eye(n) - inv(A))* y;
s = A\y;
end

function A = MatrixA(m, lambda)
K = MatrixK(m);
I = eye(m);
A = I + lambda* (K'* K);
end

function K = MatrixK(m)
K = zeros(m - 2, m);
for i = 1:(m - 2)
    K(i, i) = 1;
    K(i, i + 1) = -2;  
    K(i, i + 2) = 1;
end
end