function [Vt,At,Ct,Ap,Am,Cm] = value_matriz(T,beta,sigma,r,A,Z,liq)

%Wage
w = Z(1:T);

%Access to credit
b = zeros(1,T+1);
for t = T:-1:1 
    b(t) = (b(t+1)-w(t))/(1+r);  
        if b(t) >= -liq % No activa
            b(t) = b(t);
        else 
            b(t) = -liq;% Activa
        end  
end
b_pos_p = sum(A<b(end)) + 1; 


% Preallocation
Vt = NaN(length(A),T+1); %Value matrix
Vt(b_pos_p:end,end) = 0; 
Ap = NaN(length(A),T);   %Asset matrix position
Am = Ap;                 %Asset matrix value
Cm = Ap;                 %Consumption matrix


%Value function iteration
for t = T:-1:1   
        b_pos = sum(A<b(t)) + 1;
        c = w(t) + (1+r).*A(b_pos:end) - A(b_pos_p:end)';
        c(c<=0)=NaN; 

        Vaux = util(c,sigma) + beta*Vt(b_pos_p:end,t+1)';
        disp(size(c))
        [V,P] = max(Vaux,[],2);
   
        Vt(b_pos:end,t) = V; 
        Ap(b_pos:end,t) = b_pos_p - 1 + P;    
        Am(b_pos:end,t) = A(b_pos_p - 1 + P);
        Cm(b_pos:end,t) = w(t) + (1+r).*A(b_pos:end) - A(b_pos_p - 1 + P);
        b_pos_p = b_pos;
end


%Policies functions
Asset_life_pos = NaN(1,T);
Asset_life_pos(1) = sum(A<0)+1;

for t = 2:T+1
    Asset_life_pos(t) = Ap(Asset_life_pos(t-1),t-1);
end

At = A(Asset_life_pos)'; %Policy function assets
Ct = w(1:T) + (1+r)*At(1:T) - At(2:T+1); %Policy function consumption
end