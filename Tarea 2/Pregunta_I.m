%% Question I creating a new iterative algoritm with my style
clear; clc;

% parameters
T = 70;
b = 0.96;
sigma = 2;
h = 111111110;

% wage vector
wf = @(t) 1.5 + 5*10^(-2)*t - 10^(-3)*t.^2;
w = wf(1:T);
plot(1:T, w);

% creating my asets grill
A = linspace(-15,25, 1001);

%% a) and b) are not numeric questions
% c) so, we have a r interest rate 
r = (1 - b)/b;

[Copt, Vopt, Aopt] = V(A, r, w, T, b, sigma, h);

Aoptp = circshift(Aopt, -1);
Copt1 = w + (1 + r)* Aopt - Aoptp; 
plot(1:T, Aopt, 1:T, Copt, 1:T, w)
xlabel("T")
legend("Assets", "consuption", "Wage")

% this specific interest rate is the cause of the constant consuption 

%% d)
wf2 = @(t) 1.5 + 9*10^(-2)*t - 10^(-3)*t.^2;
w2 = wf2(1:T);
figure("Name","wage")
plot(1:T, wf(1:T), 1:T, wf2(1:T));
legend("w1", "w2");

% crearly this new salary structure is better than the first one
[Copt, Vopt, Aopt] = V(A, r, w2, T, b, sigma, h);

figure("Name","consuption")
Aoptp = circshift(Aopt, -1);
Copt = w2 + (1 + r)* Aopt - Aoptp; 
plot(1:T, Aopt, 1:T, Copt, 1:T, w2)
xlabel("T")
legend("Assets", "consuption", "Wage")

%% e)

wf3 = @(t) 1.5 + 7*10^(-2)*t - 10^(-3)*t.^2;
w3 = wf3(1:T);
figure("Name","wage")
plot(1:T, wf(1:T), 1:T, wf2(1:T), 1:T, wf3(1:T));
legend("w1", "w2", "w3");

[Copt, Vopt, Aopt] = V(A, r, w3, T, b, sigma, h);

figure("Name","consuption")
Aoptp = circshift(Aopt, -1);
Copt = w3 + (1 + r)* Aopt - Aoptp; 
plot(1:T, Aopt, 1:T, Copt, 1:T, w3)
xlabel("T")
legend("Assets", "consuption", "Wage")
title("r = (1-b)/b, sigma = 2")

figure("Name","Diferent r and sigma")

subplot(1,2,1);
r1 = 0.05;
[Copt, Vopt, Aopt] = V(A, r1, w3, T, b, sigma, h);

Aoptp = circshift(Aopt, -1);
Copt = w3 + (1 + r1)* Aopt - Aoptp; 
plot(1:T, Aopt, 1:T, Copt, 1:T, w3)
xlabel("T")
legend("Assets", "consuption", "Wage")
title("r = 0.05, sigma = 2")

subplot(1,2,2);
sigma1 = 8;
[Copt, Vopt, Aopt] = V(A, r, w3, T, b, sigma1, h);

Aoptp = circshift(Aopt, -1);
Copt = w3 + (1 + r)* Aopt - Aoptp; 
plot(1:T, Aopt, 1:T, Copt, 1:T, w3)
xlabel("T")
legend("Assets", "consuption", "Wage")
title("r = (1-b)/b, sigma = 8")
