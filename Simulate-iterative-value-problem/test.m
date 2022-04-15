%% we will use a grill

a = 1;
c = linspace(0, a, 100);
b = 0.5;
R = 1;

c = linspace(0.001, 1, 1000);

ut_0 = 0;
for i = c
    ds = discount_plus(@ut, 1, sqrt(0.75), i);
    if ds > ut_0
        c_opt = i;
        ut_0 = ds;
    end
end

function u = ut(x)
u = sqrt(x);
end

function ds = discount_plus(ut, a, b, p)

if a <= 0.001
    ds = 0;

else
    c = p*a;
    disp(b)
    ds = ut(c) + b*discount_plus(@ut ,a - c, b, p);
end
end

