%% Pregunta 2 Data del Banco
clear;
clc;

DataBC = readtable('Data_BC.xlsx');
DataBC(1,:) = [];

%% Separacion de la data
% a)
cu = table2array(DataBC(:, 2));
p = table2array(DataBC(:, 3));
inf = table2array(DataBC(:, 4));

%% b) funcion que descompone
[c, s] = HP(cu, 14400);

%% c) graficar
[c_l, s_l] = HP(cu, 6.25);
[c_M, s_M] = HP(cu, 1600);
[c_H, s_H] = HP(cu, 129000);
x = 1:length(s);
plot(x, s_l, x, s_M, x, s_H, x, s + c, "--")
title("Desc HP")
ylabel("precio del cobre")
xlabel("tiempo")
legend("6.25","1600","129000","Serie normal")

%% d) regresion lineal
% los vectores con data t - 1
cu_s = circshift(cu, 1);
cu_s(1) = 0;
p_s = circshift(p, 1);
p_s(1) = 0;
inf_s = circshift(inf, 1);
inf_s(1) = 0;
% Creamos las X
unos = ones(size(inf, 1), 1);
M1 = [unos inf_s cu cu_s];
M2 = [unos inf_s p p_s];
M1(1, :) = [];
M2(1, :) = [];
% ajustamos la y
inf_y = inf;
inf_y(1) = [];

betas1 = (M1'*M1)\M1'*inf_y;
betas2 = (M2'*M2)\M2'*inf_y;

% Estas regresiones son series de tiempo que buscan predecir cambios
% futuros en la inflación basados en la inflación de ciertos episodios
% anteriores, sin embargo, también es posible añadir predictores
% diferentes a su mismo valor en el pasado. En este caso, usamos dos
% modelos, uno que utiliza el precio del cobre como predictor, y otro que
% usa el precio del petroleo. En mi opinión esto permiete identificar que
% parte de la inflación es explicada por un fenomeno interno, o dicho de
% otra manera, que parte de la inflación es traducida en un cambio de
% precios dentro del país y que parte del cambio es a causa de un cambio en
% los precios de los commodities. 

%% functions

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


