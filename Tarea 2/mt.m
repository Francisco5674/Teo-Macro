function m = mt(g, T)
auxtotal = 0;
m = [];
for i = 1:T
G = (1 + g)^(T - i);
auxtotal = auxtotal + G;
m = [m G];
end
m = m./auxtotal;
end

