function [suply, demand, consuption_mean, Assets_mean, production] =...
    marketg(r, N, T, alpha, states, rho,...
    sigmamu, beta, sigma, A, tol, delta, tau)
w = (1 - alpha)*(alpha/(delta + r))^(alpha/(1 - alpha));

[pro,tr]= discAR(states, rho, sigmamu);
[panel_S_aux,~,e_bar] = distest(N,T,tr,pro);
L = mean(pro(panel_S_aux(:, end)));
[Cti,Ati,Vf,Ap] = valueg(beta,sigma,r,w,A,tol,pro,tr, L, tau);
[Assets, Consuption] = simulate(Ap,Cti,panel_S_aux, A);

L = mean(pro(panel_S_aux(:, end)));
Assets_mean = mean(Assets, 2);
suply = mean(Assets_mean(1001:end));
demand = L*(alpha/(delta + r))^(1/(1-alpha));
K = demand;
consuption_mean = mean(Consuption, 2);
production = (L^(1-alpha))*(K^alpha);

end