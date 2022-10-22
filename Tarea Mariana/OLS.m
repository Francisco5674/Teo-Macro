function betas = OLS(X,y)
X = [ones(length(y),1) X];
betas = (X'*X)\X'*y;
end

