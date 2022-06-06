function x = BS(f, a, b)
m = (a+b)/2;
value_ref = f(m);
while abs(value_ref) > 0.1
    disp(value_ref)
    disp(strcat(num2str(a),'/', num2str(m),'/', num2str(b)))
    if value_ref > 0
        b = m;
    else
        a = m;
    end
    m = (a+b)/2;
    value_ref = f(m);
end
x = m;
end

