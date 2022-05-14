%% Consuption equation
% consuption equation

cmatrix = [];
hold on
for ci = [1.5 3 4.5 6]
    cmatrix = [cmatrix consuption(10, ci, 0.4, 0.96, 10)'];
    plot(1:10, consuption(10, ci, 0.4, 0.96, 10))
end
hold off

function c = consuption(x0, c0, alpha, beta, n)
c = c0;
for i = 1:(n-1)
    c1 = beta*alpha*c0/(x0 -c0)^(1-alpha);
    x1 = (x0 - c0)^alpha;
    x0 = x1;
    c0 = c1;
    c = [c c1];
end
end
