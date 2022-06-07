function [change, H2, H1] = gfunction(Copt1, Copt2, sigma, beta)

Vopt1 = Util(Copt1, sigma);
Vopt2 = Util(Copt2, sigma);
H1 = zeros(size(Copt1,1),1);
H2 = zeros(size(Copt2,1),1);
i = 0;
desc = beta^i;
while desc > 0.000001
    H1 = H1 + desc*Vopt1(:,i + 1);
    H2 = H2 + desc*Vopt2(:,i + 1);
    i = i + 1;
    desc = beta^i;
end
disp(strcat("finished in i=", num2str(i)))

change = (H2./H1).^(1/(1-sigma)) - 1;
end

