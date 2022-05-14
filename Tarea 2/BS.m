function x = BS(f, a, b)
m = (a+b)/2;
while abs(f(m)) > 0.1
    if f(m) > 0
        b = m;
    else
        a = m;
    end
    m = (a+b)/2;
    disp(f(m))
end
x = m;
end

