function L = Laboral_suply(T)
L = 0;
for t = 1:T
aux1 = 40/(0.4*(t + 1)*sqrt(2*pi));
aux2 = -(0.5)*((log(t + 1) - log(32.5))/0.4)^2;
productivity = aux1 * exp(aux2) + 0.4;
L = L + productivity;
end
L = L/T;
end

