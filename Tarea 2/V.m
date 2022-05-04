function [Vopt, Aopt] = V(A, r, w, T, b, sigma)
max_debt = find_max_debt(r, w);
Vmatrix = zeros(length(A), T + 1);
Assets_pos = zeros(length(A), T);

for t = T:-1:1
    A_sp = factible_grill(max_debt, t + 1, A);
    A_s = factible_grill(max_debt, t, A);
    c = w(t) + (1 + r)* A_s' - A_sp;
    c(c<=0) = 0;
    
    finish_pos = (length(A) + 1 - length(A_sp));
    V_tp = Vmatrix(finish_pos:(length(A)),(t + 1))';

    Value_f = util(c, sigma) + b * V_tp;
    [max_value, position] = max(Value_f,[],2);
    start_pos = (length(A) + 1 - length(A_s)):(length(A));
    Vmatrix(start_pos,t) = max_value; 
    Assets_pos(start_pos:end,t) = finish_pos + position - 1; 
end
Vopt = Vmatrix;
Assets_opt_pos = [];
Assets_opt_pos(1) = sum(A<0) + 1;
for t = 2:T
Assets_opt_pos(t) = Assets_pos(Assets_opt_pos(t - 1), t - 1);
end
Aopt = A(Assets_opt_pos);
end



% with the max debt amount i need to slice the A grillmax_debt
function A_s = factible_grill(max_d, t, A)
min_b = max_d(t);
A_s = A((sum(A<min_b) + 1):length(A));
end

% I need to know the max amount of debt in each period

function max_debt = find_max_debt(r, w)
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
    max_debt(t) = present_value;
    else
    max_debt(t) = 0;
    end
end
max_debt = - max_debt;
max_debt(length(max_debt) + 1) = 0;
end