function rho = corrp(Var1, Var2)
desv1 = (Var1 - mean(Var1));
desv2 = (Var2 - mean(Var2));
sd1 = sqrt(sum(desv1.^2));
sd2 = sqrt(sum(desv2.^2));

rho = dot(desv1,desv2)/(sd1*sd2);
end

