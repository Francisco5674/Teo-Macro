clear variables; close all; clc
tic

% Parameters
beta= 0.96; sigma= 2; T= 500000;
% marginal utility
up= @(c) c.^(-sigma);


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
% stochastic discount factor: (y,yp)
M= beta*up(yg')./up(yg);
% equilibrium prices
p= (eye(4) - Pi.*M)\(Pi.*M)*yg;


%----------------------%
% Interest Rates
%----------------------%
% risk free return rates
rf= up(yg)./( beta*Pi*up(yg) )  - 1;        
% risky return rates
Rr= (p' + yg')./p;
% expected risky return
Er= Pi*(p + yg)./p -1;
% risk premiums
rp= Er - rf;

%%
%---------------------%
% Paths
%---------------------%
% initialization
yti= zeros(1,T+1); yti(1)= 3;
Picdf= cumsum(Pi,2);
% uniform draws
et= rand(1,T);

% aggregate productivity path
for it= 2:T+1
    
    % state
    is0= yti(it-1);
    
    % transition
    is1= 1;                                 % initialization
    e= et(it-1);                            % uniform draw
    while ( e> Picdf( is0, is1) )           % transition to y'
        is1= is1 + 1;
    end
    
    % store
    yti(it)= is1;    
end


% product
yt= yg(yti);
% consumption
ct= yt;
% risk free interest rate
rft= rf(yti);
% price
pt= p(yti); 

toc