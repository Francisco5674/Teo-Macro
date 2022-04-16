%% Pregunta 3.1 Encontrar raices 

clear;
clc;

% a) veamos las raices de las fuinciones

% primero, verifiquemos que valor esta cerca de donde puede estar la raiz 

x = linspace(-10, 10, 200);
subplot(3, 1, 1)
plot(x, f1(x));
title("f1")
subplot(3, 1, 2)
plot(x, f2(x));
title("f2")
subplot(3, 1, 3)
plot(x, f3(x));
title("f3")

% conluimos que el 2 es un  valor en el dominio razonable para usar
xnr_1 = NR(@f1, @fprima1, 2);
xnr_2 = NR(@f2, @fprima2, 2);
xnr_3 = NR(@f3, @fprima3, 2);

% b) de lo que vimos anteriormente tenemos que entre -10 y 10 se encuentra
% lo que buscamos
xbs_1 = BS(@f1, -10, 10);
xbs_2 = BS(@f2, -10, 10);
xbs_3 = BS(@f3, -10, 10);

% c) El algortimo de Newton Raphson parece requerir una cantidad menor de
% iteraciones debido a que es capaz de acercarse más rápido a la raíz
% buscada, sin embargo, este necesita de la primera aproximación lineal 
% para funcionar, es decir, requiere cáluclo diferencial. Por otro lado,
% el metodo de bisección es mucho más lento puesto que recorre distancias
% siempre de la misma proporción, pero no neceesita de la primera
% aproximación lineal para funcionar. En otras palabras, nos encontramos
% frente a dos algortimos válidos, uno más rápido pero con requerimiento
% de información adicional y otro que no requiere más que la función
% original pero más lento. Dependiendo de las preferencias y del problema
% qu estemos solucionando puede ser conveniente uno u otro. 

% d) use funciones para hacer los ejercicios anteriores, y estas se basan
% en algoritmos, en otras palabras, para que trabajar doble?

%% Pregunta 3.2 Algo de fisica
% a) consiguiendo los maximos

% veamos la posición de la pelota con respcto al tiempo
x = linspace(0, 1, 200);
figure();
plot(x, H(x));
title("H");

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
h = 50 + 450*t - 0.5*981*t.^2;
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
f = log(3*x.^4);
end

function f = fprima3(x)
f = x.^1 + 3*x.^-1;
end

