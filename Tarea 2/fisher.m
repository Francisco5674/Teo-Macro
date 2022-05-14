function K = fisher(r, delta, alpha, L)
K = L*(alpha/(r + delta))^(1/(1-alpha));
end

