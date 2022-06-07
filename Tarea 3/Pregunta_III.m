%% Now it is time to find the general equilibrium with goverment
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
tau = 0.12;

%% a) first ill need L

[pro,tr]= discAR(states, rho, sigmamu);
[panel_S_aux,~,e_bar] = distest(N,T,tr,pro);
L = mean(pro(panel_S_aux(:, end)));
[Cti,Ati,Vf,Ap] = valueg(beta,sigma,r,w,A,tol,pro,tr,L,tau);

tx= {'Interpreter','Latex','FontSize', 15};

figure (1);
sgtitle('\textbf{Uncertainty: Matrix}',tx{:},'Fontsize',20)

subplot (2,2,1)
d = plot(A,Cti(:,:));
xlabel('Assets',tx{:})
title('\textbf{Consumption}',tx{:})
legend([d(1),d(length(pro))],'$\varepsilon_1 = 0.48$',...
    '$\varepsilon_5 = 1.74$',tx{:},'fontsize',10,'location','SE'); 
d(1).LineWidth = 2;
d(length(pro)).LineWidth = 2;

subplot(2,2,2)
p = plot(A,Ati(:,:));
xlabel('Assets',tx{:})
title('\textbf{Assets}',tx{:})
legend([p(1),p(length(pro))],'$\varepsilon_1$ = 0.48',...
    '$\varepsilon_5 = 1.74$','location','SE',tx{:},'fontsize',10); 
p(1).LineWidth = 2;
p(length(pro)).LineWidth = 2;

subplot(2,2,[3,4])
f = plot(A,Vf(:,:));
xlabel('Assets',tx{:})
title('\textbf{Value function}',tx{:});
legend([f(1),f(length(pro))],'$\varepsilon_1 = 0.48$',...
    '$\varepsilon_5 = 1.74$',tx{:},'fontsize',10,'location','SE'); 
f(1).LineWidth = 2;
f(length(pro)).LineWidth = 2;

[Assets, Consuption] = simulate(Ap, Cti, panel_S_aux, A);

Assets = Assets(:,1001:end);
Consuption = Consuption(:,1001:end);

Assets_mean = mean(Assets, 2);
Assets_mean_mean = mean(Assets_mean);
Assets_median = prctile(Assets_mean, 50);
Assets_10 = prctile(Assets_mean, 10);
Assets_90 = prctile(Assets_mean, 90);
Assets_99 = prctile(Assets_mean, 99);

Consuption_mean = mean(Consuption, 2);
Consuption_mean_mean = mean(Consuption_mean);
Consuption_median = prctile(Consuption_mean, 50);
Consuption_10 = prctile(Consuption_mean, 10);
Consuption_90 = prctile(Consuption_mean, 90);
Consuption_99 = prctile(Consuption_mean, 99);

figure(2)
subplot(1,2,1)
histogram(Consuption_mean,100)
title("Consuption mean")
subplot(1,2,2)
histogram(Assets_mean, 100)
title("Assets mean")

%% b) effects in welfare
tau = 0.04;
[pro,tr]= discAR(states, rho, sigmamu);
[panel_S_aux,~,e_bar] = distest(N,T,tr,pro);
L = mean(pro(panel_S_aux(:, end)));
[Cti,Ati,Vf1,Ap] = valueg(beta,sigma,r,w,A,tol,pro,tr,L,tau);
[Assets, Consuption1] = simulate(Ap, Cti, panel_S_aux, A);

tau = 0.12;
[pro,tr]= discAR(states, rho, sigmamu);
[panel_S_aux,~,e_bar] = distest(N,T,tr,pro);
L = mean(pro(panel_S_aux(:, end)));
[Cti,Ati,Vf2,Ap] = valueg(beta,sigma,r,w,A,tol,pro,tr,L,tau);
[Assets, Consuption2] = simulate(Ap, Cti, panel_S_aux, A);

%%
[change, H2, H1] = gfunction(Consuption1(:,1001:end)...
    , Consuption2(:,1001:end), sigma, beta);
figure(3)
subplot(2,2,1)
histogram((H2 - H1)/(sqrt(var(H2 - H1))), 100)
[t,s] = title('Effective change in welfare (Normalized difference)',...
    'tau = 0.04 -> tau = 0.12');
subplot(2,2,2)
histogram(change, 100)
[t,s] = title('Effective change in welfare (Function g(a,e))',...
    'tau = 0.04 -> tau = 0.12');
subplot(2,2,3)
hold on
[t,s] = title('Effective Value function',...
    'tau = 0.04 (Orange) -> tau = 0.12 (Blue)');
h2 = histogram(H2, 100, 'Normalization', 'probability');
h1 = histogram(H1, 100, 'Normalization', 'probability');
hold off
subplot(2,2,4)
Vdif = (Vf2./Vf1).^(1/(1-sigma)) - 1;
plot(A, Vdif(:,:))
title('Expected change in welfare (Function g(a,e))')
legend('shock 1','','','','shock 5'); 
%% c) looking for equlibrium
tau = 0.075;
r_e = BS(@(R) delta_marketg(R, N, T, alpha, ...
    states, rho, sigmamu, beta, sigma, A, tol, delta, tau), 0.001, 0.05);



