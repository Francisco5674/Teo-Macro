clear variables; close all; clc

%----------------------
% Parameters
%----------------------
sigma= 1;  beta= .984;  delta=.025;  alpha=1/3;
rho= 0.97;  sde= .0072;

% Grid points
nz= 3; % Productivity 
nk= 21;% Kapital

% Utility function
utility= @(c)  crra(c, sigma);

% Transition matrix
[zg,Pi]= tauchen(rho,sde,3,nz);
% Productivity grid
zg= exp(zg');  
nz= length(zg);


% Capital SS
Kss= @(z)  (  z*alpha / (1/beta -(1-delta))  )^( 1/(1-alpha) ); 

% Capital bounds
kss= Kss(1);

% Capital grid
kmin= 0.2*kss;  
kmax= 1.4*kss;
kg= linspace(kmin,kmax,nk);
nk= length(kg);


%----------------------
% VFI
%----------------------
tol= 1e-4;  maxiter= 1000;  showiter= 20;

% Preallocation
v0= zeros(nz,nk);   %value function
kpf= zeros(nz,nk);  %Policy capital 

% Initialization
err= 1;  
iter= 0;
v1= zeros(nz,nk);

tic
% Value function iteration
while err>tol
    
    % Continuation value: E[ V1 |z ]
    Ev1= Pi*v1;
    
    % Loop over productivity
    for iz= 1:nz
            
        % Piecewise polinomial: spline on E[ V1 |z=zi ]
        vpp= spline(kg, Ev1(iz,:));

        % Loop over capital
        for ik= 1:nk
            % Objective for minimization
            obj= @(kp)  -vaux(zg(iz),kg(ik),kp, ...
                                beta,delta,alpha,utility,vpp);
                            
            % k' bounds
            kub= min(kmax, zg(iz)*kg(ik)^alpha + (1-delta)*kg(ik));

            % Policy function: max k' over [klb,kub]
            [kpf(iz,ik),vneg]=  fminbnd(obj,kmin,kub);
            % Value function
            v0(iz,ik)= -vneg;
        end
    end
    
    % Norm
    err= max(max(abs(v0-v1)));
    % Value update
    v1= v0;
    
    % Iterations
    iter= iter+1;
    if (iter>maxiter), break; end
    % Display
    if mod(iter,showiter)==0
        fprintf('err: %.2e  |  iter: %d \n',[err,iter]);
    end
end
toc
% Output message
if (iter<maxiter)
    fprintf('VF converged:  %.2e  |  iter: %d \n',[err,iter])
else
    warning('Error: Iterations exceeded')
end


% Consumption policy
cpf= zg*kg.^alpha + (1-delta)*kg  - kpf;



tx= {'Interpreter','Latex'};

figure(1);
% Capital policy
hold on
plot( kg, kg, 'Linestyle',':','color','k')
plot( kg, kpf);
hold off
title('Capital Policy')
xlabel('$k$', tx{:}); ylabel("$k^\prime$", tx{:})
legend('45°','capital policy' ,'Location','SE')

% Consumption policy
figure(2)
plot( kg, cpf);
title('Consumption Policy')
xlabel('$k$', tx{:}); ylabel("$c$", tx{:})
legend('consumption policy' ,'Location','SE')

%% 1)
%* El capital si converge a su estado estacionario cualquiera sea el nivel
%de productividad, esto se aprecia claramente en la figura 1 donde la
%pendiente es menor que 1.
%* La velocidad de convergencia se determina por la pendiente:
disp((kpf(:,end) - kpf(:,1))./(kg(end) - kg(1)))
% cada pendiente es muy cercana a 0.96, en otras palabras es cercana a 1.
% Así que a pesar de que el estado estacionario es localmente estable, no
% se cartacteriza por tener una velocidad de convergencia muy alta. 

%% 2)
%----------------------
% Stochastic SS
%----------------------
% Periods
Tsss= 500;

% Deterministic SS
isss= 2;

% Capital path
kt= zeros(1,Tsss);
kt(1)= Kss(1);

for it= 2:Tsss
   kt(it)= interp1(kg, kpf(isss,:) , kt(it-1));
end

% Stochastic SS
ksss= kt(end);
csss= interp1(kg, cpf(isss,:) , ksss );
ysss= zg(isss)*ksss^alpha;
invsss= ysss - csss;

%----------------------
% Capital shock
%----------------------
T= 80;  tg= 1:T;


% Preallocation
kt= zeros(1,T+1);  
ct= zeros(1,T);  
yt= ct;  
invt= ct;

% Initial conditions
kt(1)= ksss*1.01;

% path
for it= 1:T
   % Consumption
   ct(it)= interp1(kg,cpf(isss,:),kt(it));
   % Output
   yt(it)= zg(isss)*kt(it)^alpha;
   % Investment
   invt(it)= yt(it) - ct(it);
   % Capital
   kt(it+1)= interp1(kg, kpf(isss,:) , kt(it) );
end


%----------------------
% Plots

figure(3);
% Capital path
subplot(2,2,1)
hold on
plot( 1:T+1, kt);
plot( [1 T+1], [ksss ksss], 'Linestyle',':','color','k')
hold off
title('Capital')
% Consumption path
subplot(2,2,2)
hold on
plot( 1:T, ct);
plot( [1 T], [csss csss], 'Linestyle',':','color','k')
hold off
title('Consumption')
% Investment
subplot(2,2,3)
hold on
plot( 1:T, invt);
plot( [1 T], [invsss invsss], 'Linestyle',':','color','k')
hold off
title('Investment')
% Output
subplot(2,2,4)
hold on
plot( 1:T, yt);
plot( [1 T], [ysss ysss], 'Linestyle',':','color','k')
hold off
title('Output')

% como respuesta inmediata al aumento de capital, el output y por ende el
% consumo se ajustan inmediatamente al alza ya que como es evidente la
% producción aumenta de golpe. Mientras que la inversión se ajusta a la
% baja con tal de regresar al capital del estado estacionario. 

%% 3)
% Preallocation
kt= zeros(1,T+1);
ct= zeros(1,T);  
yt= ct;  
invt= ct;

% Productivity path
zt= zg(isss)*ones(1,T+1);

% Purely transitory shock
zt(1)= zg(isss)*0.99;

% Initial conditions
kt(1)= ksss;
% Time path
for it= 1:T
   % Consumption
   ct(it)= interp2(kg,zg,cpf,kt(it),zt(it));
   % Output
   yt(it)= zt(it)*kt(it)^alpha;
   % Investment
   invt(it)= yt(it) - ct(it);
   % Capital
   kt(it+1)= interp2(kg,zg, kpf, kt(it),zt(it) );
   % Productivity
   zt(it+1)= exp( rho*log(zt(it)) ); %e^{z_t}
end

% Percentage deviation
khat= log(kt(2:end))-log(ksss);
chat= log(ct(2:end))-log(csss);
yhat= log(yt(2:end))-log(ysss);
invhat= log(invt(2:end))-log(invsss);
zhat= log(zt(2:end))-log(zt(end));


%----------------------
% Plots

figure;
% Capital path
subplot(3,2,1)
hold on
plot( 1:T, khat);
hold off
title('Capital')
% Consumption path
subplot(3,2,2)
hold on
plot( 1:T-1, chat);
hold off
title('Consumption')
% Investment
subplot(3,2,3)
hold on
plot( 1:T-1, invhat);
hold off
title('Investment')
% Output
subplot(3,2,4)
hold on
plot( 1:T-1, yhat);
hold off
title('Output')
% Productivity
subplot(3,2,5)
hold on
plot( 1:T, zhat);
hold off
title('TFP')

% En este caso, es claro que el output y el consumo bajan de manera
% inmediata, sin embargo, la inversión también lo hace pero no así el
% capital. Esta diferencia temporal se debe a que el capital se ajusta con
% la inversión del preiodo anteior, lo que provoca que el cambio del stock
% de este recurso NO sea inmediato. Notar que al capital le toma unos
% cuantos periodos en ajustarse a la baja, luego de esto la economía
% comienza a regresar al estado estacionario. El análisis desde el momento
% en que el capital comienza a subir es el mismo como si el shock hubiera
% afectado negativamente el stock de este recurso en el periodo 25 en
% adelante. 