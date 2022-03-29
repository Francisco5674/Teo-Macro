%% Pregunta 3.1 Encontrar raices 

% a) veamos las raices de las fuinciones
xnr_1 = NR(@f1, @fprima1, 2);
xnr_2 = NR(@f2, @fprima2, 2);
xnr_3 = NR(@f3, @fprima3, 2);

% b)
xbs_1 = BS(@f1, -10, 10);
xbs_2 = BS(@f2, -10, 10);
xbs_3 = BS(@f3, -10, 10);

% c) Ni idea

% d) use funciones para hacer los ejercicios anteriores, y estas se basan
% en algoritmos, en otras palabras, para que trabajar doble?


%% Pregunta 3.2 Algo de fisica
% a) consiguiendo los maximos

hnr = NR(@Hprima, @Hprimaprima, 2);
hbs = BS(@Hprima, 1, -1);

% b) 

disp(H(hnr));
% la medida anterior son cm

% c)
disp(Hprima(hnr));
% aprox no tiene velocidad en ese punto


%% Primero las funciones 

% movimiento de la pelota
function h = H(t)
h = 50 + 450*t - 0.5*981*t^2;
end

function h = Hprima(t)
h = 450 - 981*t;
end

function h = Hprimaprima(t)
h = - 981;
end

% metodo de biseccion
function x = BS(f, a, b)
m = (a+b)/2;
while abs(f(m)) > 10^-4
    if f(m) > 0
        b = m;
    else
        a = m;
    end
    m = (a+b)/2;
end
x = m;
end


% metodo newton raphson
function x = NR(func, funcp, a)
x0 = a;
fx0 = func(x0);
fpx0 = funcp(x0);
x1 = x0 - (fx0/fpx0);
fx1 = func(x1);
while abs(fx1) > 10^-4
    x0 = x1;
    fx0 = func(x0);
    fpx0 = funcp(x0);
    x1 = x0 - (fx0/fpx0);
    fx1 = func(x1);
end
x = x1;
end


function f = f1(x)
f = x.^3 - x + 2;
end

function f = fprima1(x)
f = 3*x.^2 - 1;
end

function f = f2(x)
f = x.^5 + x.^4 + x.^3 + x.^2 + x + 1;
end

function f = fprima2(x)
f = 5*x.^4 + 4*x.^3 + 3*x.^2 + 2*x + 1;
end

function f = f3(x)
f = log(x) + log(3*x.^3);
end

function f = fprima3(x)
f = 1/x + 3/x;
end

