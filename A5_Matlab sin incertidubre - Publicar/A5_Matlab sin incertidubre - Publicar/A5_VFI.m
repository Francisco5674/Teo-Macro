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
Z  = @(t) 1.25 + (6e-2)*t - (1e-3)*t.^2;
w = Z(1:T);
w_mean = mean(w)*ones(1,T);
plot(1:T, w)

% studing


%% 

%Value function iteration
tic
[Vt,At,Ct,Ap,Am,Cm] = value_matriz(T,beta,sigma,r,A,Z,liq);
toc


%Plot 
tx= {'Interpreter','Latex','FontSize', 15};

figure(6)
sgtitle('Partial Equilibrium - Matrix',tx{:},'FontSize', 20)
subplot(2,2,1)
plot(1:T,w,1:T,w_mean);
xlabel('T',tx{:})
title('Wage evolution',tx{:},'FontSize', 15)
legend('Wage', 'Mean',tx{:});

subplot(2,2,2)
plot(1:T,At(1:T), 1:T, Ct)
xlabel('T',tx{:})
title('Assets',tx{:},'FontSize', 15)

subplot(2,2,[3,4])
plot(1:T,Ct)
xlabel('T',tx{:})
title('Consumption',tx{:},'FontSize', 15)

%% Equilibrio parcial con loop

tic
[Vt,At,Ct,Ap,Am,Cm] = value_loop(T,beta,sigma,r,A,Z,liq);
toc

%Plot 
tx= {'Interpreter','Latex','FontSize', 15};

figure(2)
sgtitle('Partial Equilibrium - Loop',tx{:},'FontSize', 20)
subplot(2,2,1)
plot(1:T,w,1:T,w_mean);
xlabel('T',tx{:})
title('Wage evolution',tx{:},'FontSize', 15)
legend('Wage', 'Mean',tx{:});

subplot(2,2,2)
plot(1:T+1,At(1:end))
xlabel('T',tx{:})
title('Assets',tx{:},'FontSize', 15)

subplot(2,2,[3,4])
plot(1:T,Ct)
xlabel('T',tx{:})
title('Consumption',tx{:},'FontSize', 15)




%% Equilibrio general 

r = linspace(0.02,0.08,10);
Atp = NaN(length(r),T+1);   %Optimal asset path for each r
Aas = NaN(1,length(r));     %Aggregate asset supply 

tic
for i = 1: length(r)
[~,Atp(i,:)] = value_matriz(T,beta,sigma,r(i),A,Z,liq);

Aas(i) = (1/T)*sum(Atp(i,:));
end
toc

figure(3)
sgtitle('General Equilibrium',tx{:},'FontSize', 20)
subplot(1,2,1)
p = plot(1:T+1,Atp(:,1:end));
xlabel('T',tx{:})
title('Optimal asset path',tx{:})
lgd= legend([p(1),p(length(r))],'$r = 2\%$','$r = 8\%$',tx{:}); 
lgd.Location= 'SouthEast';
 
subplot(1,2,2)
plot(r,Aas)
xlabel('$r$',tx{:})
title('Aggregate asset supply ',tx{:})

