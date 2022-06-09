clear variables; close all; clc

% Parameters
beta= 0.96; sigma= 2;
% marginal utility
up= @(c) c.^(-sigma);
T = 300;


% transition Matrix
Pi= [.6 .15 .15 .1 ;
    .05 .65 .25 .05;
    .01 .07 .85 .07;
    .015 .05 .28 .655];

% aggregate productivity grid
yg= [.9 .97 1 1.03]';

%----------------------%
% Price vector
%----------------------%
% Stochastic discount factor: (y,yp)
M= beta*up(yg')./up(yg);
% Equilibrium prices
p= (eye(4) - Pi.*M)\(Pi.*M)*yg;

% Iterative solution
tol= 1e-8;
% parameters
error= 1;
C1=  zeros(4,1);
while (error>tol)
    C0= beta*Pi*( C1 + up(yg).*yg ); 
    error= max(abs(C0-C1));
    C1= C0;
end
% Equilibrum prices
pe= C0./up(yg);

% risky premiun
riskfree = up(yg)./( beta*Pi*up(yg) )  - 1;  
Rp = Pi*(pe + yg)./pe - riskfree;


%% now we can use the covariance 
sim = distest(1, T, Pi, yg);

DF = [];
RT = [];

for i = 1:(size(sim,2) - 1)
    producto_t1 = yg(sim(i + 1));
    precio_t1 = pe(sim(i + 1));
    precio_t0 = pe(sim(i));
    producto_t0 = yg(sim(i));
    discount_factor = beta*up(producto_t1)/up(producto_t0);
    ret = (precio_t1 + producto_t1)/producto_t0;
    DF = [DF discount_factor];
    RT = [RT ret];
end

%%
cv = cov(DF',RT');
cv = -cv(1,2);
r = cv*riskfree;



