clear variables; close all; clc
%% b)
% Parameters
beta= 0.96; sigma= 2;
% marginal utility
up= @(c) c.^(-sigma);
T = 300000;

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
Rp = Pi*(pe + yg)./pe - (1 + riskfree);
Returns = Pi*(pe + yg)./pe - 1;


%% c) now we can use the covariance 
Piac = cumsum(Pi, 2);
random_v = rand(1, T);
Ytime = zeros(1,T); Ytime(1) = 2;
for i = 2:T+1
    % base state
    pos0 = Ytime(i - 1);
    % future state
    pos1 = 1;
    while (random_v(i - 1) > Piac(pos0, pos1))
        pos1 = pos1 + 1;
    end
    Ytime(i) = pos1;
end
pos = Ytime;

%% I did it but just with 300 periods, because its exactly the same 
% situation, and as you can see, both ways of calculating the risk premiun 
% are identical 
EspRpt = []; % calculating the risk premiun with Expected Value
CovRpt = []; % calculating the riks premiun with covariance
for i = 1:300
    s = pos(i);
    m = M(s,1:4);
    prob = Pi(s,1:4);
    mesp = dot(prob,m);
    pt0 = p(s);
    Resp = dot(prob, p + yg)/pt0;
    Rf = 1/dot(prob,m);
    EspRp = Resp - Rf;

    EspRpt = [EspRpt EspRp];

    Erm = dot(prob,((p + yg)'.*m));
    Erm = Erm/pt0;
    cv = Erm - Resp*mesp;
    CovRp = -Rf*(cv);

    CovRpt = [CovRpt CovRp];
end

