function [dif] = delta_market(r, N, T, alpha, states, rho,...
    sigmamu, beta, sigma, A, tol, delta)
w = (1 - alpha)*(alpha/(delta + r))^(alpha/(1 - alpha));

[pro,tr]= discAR(states, rho, sigmamu);
[Cti,Ati,S,Vf,Ap] = value(beta,sigma,r,w,A,tol,pro,tr);
[panel_S_aux,~,e_bar] = distest(N,T,tr,pro);
[Assets, Consuption] = simulate(Ap,Cti,panel_S_aux, A);

L = mean(pro(panel_S_aux(:, end)));
Assets_mean = mean(Assets, 2);
suply = mean(Assets_mean(1001:end));
demand = L*(alpha/(delta + r))^(1/(1-alpha));

dif = suply - demand;
end

