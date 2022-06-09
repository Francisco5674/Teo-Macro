clear variables; close all; clc

% Parameters
beta= 0.96; sigma= 2; T= 500000;
% Marginal utility
up= @(c) c.^(-sigma);


% Transition Matrix
Pi= [.6 .15 .15 .1 ;
    .05 .65 .25 .05;
    .01 .07 .85 .07;
    .015 .05 .28 .655];

% Aggregate productivity grid
yg= [.9 .97 1 1.03]';


%----------------------%
% Price vector
%----------------------%
% Stochastic discount factor: (y,yp)
M= beta*up(yg')./up(yg);
% Equilibrium prices
p= (eye(4) - Pi.*M)\(Pi.*M)*yg;

%----------------------%
% Iterative soln
%----------------------%
tol= 1e-8;
% Initialization
err= 1; iter= 0;
f1=  zeros(4,1);
% Contraction mapping
while (err>tol)
    f0=  beta*Pi*( f1 + up(yg).*yg ); 
    err= max(abs(f0-f1));
    f1=    f0;
    iter= iter+1;
    if (iter>1000), break; end
end
% Equilibrum prices
p0= f0./up(yg);


%----------------------%
% Interest Rates
%----------------------%
% Risk free return rates
rf= up(yg)./( beta*Pi*up(yg) )  - 1;
% Risky return rates
rr= (p' + yg')./p;
% Expected risky return
Er= Pi*(p + yg)./p -1;
% Risk premiums
rp= Er - rf;


%---------------------%
% Paths
%---------------------%
% Initialization
yti= zeros(1,T+1); yti(1)= 3;
Picdf= cumsum(Pi,2);
% Uniform draws
draws= rand(1,T);

% Aggregate productivity path
for it= 2:T+1

    % Initialization
    is= yti(it-1);  isp= 1;
    % State draw
    sdraw= draws(it-1);
    while sdraw> Picdf( is, isp)
        isp= isp + 1;
    end
    % State transition
    yti(it)= isp;
        
end



% Product
yt= yg(yti);
% Consumption
ct= yt;
% Risk free interest rate
rft= rf(yti);
% Price
pt= p(yti); 

yti= yti(1:end-1);
ytp= yt(2:end);
ptp= pt(2:end);  pt= pt(1:end-1);
ctp= ct(2:end);  ct= ct(1:end-1);


%-------------------------------------------------------------------------%

% Stochastic discount factor
mt= beta*up(ctp) ./up(ct);
% Risky return
Rrt= ( ptp + ytp )./ pt;

% Risk premium
premium= zeros(length(yg),1);
% Loop over states
for iy= 1:length(yg)
    % Conditional covariance matrix:  cov( u'(c'), rr' | y)
    Cov= cov( up(ctp(yti==iy)) , Rrt(yti==iy) );
    % Risk premium
    premium(iy)= -Cov(1,2)/mean( up(ctp(yti==iy)) );
end

% Risk premium 2
premium2= zeros(length(yg),1);
% Loop over states
for iy= 1:length(yg)
    % Conditional covariance matrix:  cov( u'(c'), rr' | y)
    Cov= cov( mt(yti==iy) , Rrt(yti==iy) );
    % Risk premium
    premium2(iy)= -(1+rf(iy))*Cov(1,2);
end

disp( 100*[rp premium premium2] )
