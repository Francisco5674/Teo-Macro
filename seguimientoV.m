%% creating a new iterative algoritm with my style
clear; clc;

% parameters
T = 65;
b = 0.96;
sigma = 2;
r = 0.04; 

% wage vector
wf = @(t) 1.25 + 6*10^(-2)*t - 10^(-3)*t.^2;
w = wf(1:T);
plot(1:T, w);

% creating my asets grill
A = linspace(-15,25, 1001);

%% Part 1 Ayudantia
% a)
[Vopt, Aopt] = V(A, r, w, T, b, sigma);

Aoptp = circshift(Aopt, -1);
Copt = w + (1 + r)* Aopt - Aoptp; 
plot(1:T, Aopt, 1:T, Copt, 1:T, w)
xlabel("T")
legend("Assets", "Consume", "Wage")

%% b) 
% figure("Name","Assets with r variations")
% hold on
% for r = linspace(0.04,0.08,5)
% [Vopt, Aopt] = V(A, r, w, T, b, sigma);
% txt = strcat("r = ", num2str(r));
% plot(1:T, Aopt, "DisplayName",txt)
% xlabel("T")
% legend show
% end
% hold off

%%
% figure("Name","Consume with r variations")
% hold on
% for r = linspace(0.04,0.08,5)
% [Vopt, Aopt] = V(A, r, w, T, b, sigma);
% Aoptp = circshift(Aopt, -1);
% Copt = w + (1 + r)* Aopt - Aoptp; 
% 
% txt = strcat("r = ", num2str(r));
% plot(1:T, Copt, "DisplayName",txt)
% xlabel("T")
% legend show
% end
% hold off

%%
% figure("Name","Assets with sgima variations")
% hold on
% for sigma = linspace(1.5,3,5)
% [Vopt, Aopt] = V(A, r, w, T, b, sigma);
% txt = strcat("sigma = ", num2str(sigma));
% plot(1:T, Aopt, "DisplayName",txt)
% xlabel("T")
% legend show
% end
% hold off

%%
% figure("Name","Consume with sgima variations")
% hold on
% for sigma = linspace(1.5,3,5)
% [Vopt, Aopt] = V(A, r, w, T, b, sigma);
% Aoptp = circshift(Aopt, -1);
% Copt = w + (1 + r)* Aopt - Aoptp; 
% 
% txt = strcat("sigma = ", num2str(sigma));
% plot(1:T, Copt, "DisplayName",txt)
% xlabel("T")
% legend show
% end
% hold off

%%
% figure("Name","Assets with beta variations")
% hold on
% for b = linspace(0.88,0.96,5)
% [Vopt, Aopt] = V(A, r, w, T, b, sigma);
% txt = strcat("beta = ", num2str(b));
% plot(1:T, Aopt, "DisplayName",txt)
% xlabel("T")
% legend show
% end
% hold off

%%
% figure("Name","Consume with beta variations")
% hold on
% for b = linspace(0.88,0.96,5)
% [Vopt, Aopt] = V(A, r, w, T, b, sigma);
% Aoptp = circshift(Aopt, -1);
% Copt = w + (1 + r)* Aopt - Aoptp; 
% 
% txt = strcat("beta = ", num2str(b));
% plot(1:T, Copt, "DisplayName",txt)
% xlabel("T")
% legend show
% end
% hold off

%% Seguimiento 5
% We will suppose that the first consume amount is correct, so:

% parameters
T = 65;
b = 0.96;
sigma = 2;
r = 0.04; 
% b)

Ceuler = [];
for t = 1:(T - 1)
Ceuler(t) = Copt(t + 1)/(Copt(t)*(b*(1+r))^(1/sigma)) - 1;
end

figure("Name", "Error in aproximation")
plot(1:(T -1), Ceuler);
legend("Error with 1001 elements")
xlabel("Time")

% The error is inevitable because thats the discret nature of the grill
% that we are using to solve this problem

%% c)

A = linspace(-15,25, 5001);
[Vopt, Aopt] = V(A, r, w, T, b, sigma);

Aoptp = circshift(Aopt, -1);
Copt_precise = w + (1 + r)* Aopt - Aoptp; 

Ceuler_p = [];
for t = 1:(T - 1)
Ceuler_p(t) = Copt_precise(t + 1)/(Copt_precise(t)*(b*(1+r))^(1/sigma)) - 1;
end

figure("Name", "A grill of 5001 elements vs 1000 elements")
plot(1:(T - 1), Ceuler, 1:(T - 1), Ceuler_p);
legend("1001 elements", "5001 elements")
xlabel("Time")

% the more devided is the grill, the better is the aproximation, we know
% that a a grill with infinite elements would be perfect to solve this kind
% of problems, but thats imposible because the computer cant solve a
% problem of that nature. Maybe there is another way to solve this with
% more precision, but, under this algorithm assumptions theres no way. 

%%
function [Vopt, Aopt] = V(A, r, w, T, b, sigma)
max_debt = find_max_debt(r, w);
Vmatrix = zeros(length(A), T + 1);
Assets_pos = zeros(length(A), T);

for t = T:-1:1
    A_sp = factible_grill(max_debt, t + 1, A);
    A_s = factible_grill(max_debt, t, A);
    c = w(t) + (1 + r)* A_s' - A_sp;
    c(c<=0) = 0;
    
    finish_pos = (length(A) + 1 - length(A_sp));
    V_tp = Vmatrix(finish_pos:(length(A)),(t + 1))';

    Value_f = util(c, sigma) + b * V_tp;
    [max_value, position] = max(Value_f,[],2);
    start_pos = (length(A) + 1 - length(A_s)):(length(A));
    Vmatrix(start_pos,t) = max_value; 
    Assets_pos(start_pos:end,t) = finish_pos + position - 1; 
end
Vopt = Vmatrix;
Assets_opt_pos = [];
Assets_opt_pos(1) = sum(A<0) + 1;
for t = 2:T
Assets_opt_pos(t) = Assets_pos(Assets_opt_pos(t - 1), t - 1);
end
Aopt = A(Assets_opt_pos);
end



% with the max debt amount i need to slice the A grillmax_debt
function A_s = factible_grill(max_d, t, A)
min_b = max_d(t);
A_s = A((sum(A<min_b) + 1):length(A));
end

% I need to know the max amount of debt in each period

function max_debt = find_max_debt(r, w)
R = [];
T = length(w);
max_debt = [];
for t = 2: T
    R(t) = (1 + r)^(-t + 1);
end    
for t = 1:T
    if t < T
    present_value = dot(w((t + 1):T),R((t + 1):T)) ;
    present_value = present_value * (1 + r)^(t - 1);
    max_debt(t) = present_value;
    else
    max_debt(t) = 0;
    end
end
max_debt = - max_debt;
max_debt(length(max_debt) + 1) = 0;
end

