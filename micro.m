
z = 1;
b = linspace(0, z, 1000);
A = 0.6;

u1 = [];
for i = 1: length(b)
    u1(i) = u(b(i), z, A);
end

plot(b, u1);

function u1 = u(b, z, A)
pr = p(b, z, A);
m1 = pr*(z - b) + ((A + b)^2)/(4*pr);
u1 = (m1^2)/(4*pr);
end

function pr = p(b, z, A)
pr = sqrt(3*(A + b)^2)/sqrt(4*(z-b+1));
end
