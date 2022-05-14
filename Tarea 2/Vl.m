function [Copt, Aopt] = Vl(A, r, w, T, b, phi, h)
max_debt = find_max_debt(r, w, h);
Vmatrix = zeros(length(A), T + 1);
Assets_pos = zeros(length(A), T);
argmax = zeros(length(A), T);

for t = T:-1:1
    A_sp = factible_grill(max_debt, t + 1, A);
    A_s = factible_grill(max_debt, t, A);
    c = (w(t) + (1 + r)* A_s' - A_sp)/(1+phi);
    c(c<=0) = 0;
    l = (phi/w(t))*c;
    l(l>1) = 1;
    l(l<=0) = 0;
    
    finish_pos = (length(A) + 1 - length(A_sp));
    V_tp = Vmatrix(finish_pos:(length(A)),(t + 1))';

    Value_f = log(c) + phi * log(l) + b * V_tp;
    [max_value, position] = max(Value_f,[],2);
    start_pos = (length(A) + 1 - length(A_s)):(length(A));
    Vmatrix(start_pos,t) = max_value; 
    Assets_pos(start_pos:end,t) = finish_pos + position - 1; 
    for i = 1:length(position)
    argmax(i,t) = c(i, position(i));
    end
end
Assets_opt_pos = [];
Assets_opt_pos(1) = sum(A<0) + 1;
Copt = [argmax(Assets_opt_pos(1))];
for t = 2:T
Assets_opt_pos(t) = Assets_pos(Assets_opt_pos(t - 1), t - 1);
Copt = [Copt argmax(Assets_opt_pos(2))];
end
Aopt = A(Assets_opt_pos);
end



% with the max debt amount i need to slice the A grillmax_debt
function A_s = factible_grill(max_d, t, A)
min_b = max_d(t);
A_s = A((sum(A<min_b) + 1):length(A));
end

% I need to know the max amount of debt in each period

function max_debt = find_max_debt(r, w, h)
R = [];
T = length(w);
max_debt = [];
for t = 2: T
    R(t) = (1 + r)^(-t + 1);
end    
for t = 1:T
    if t < T
    present_value = dot(w((t + 1):T),R((t + 1):T)) ;
    present_value = present_value * (1 + r)^(t - 1);
        if present_value > h
            max_debt(t) = h;
        else
            max_debt(t) = present_value;
        end
    else
    max_debt(t) = 0;
    end
end
max_debt = - max_debt;
max_debt(length(max_debt) + 1) = 0;
end