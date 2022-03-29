%% Seguimiento 2
% construire las funciones primero, prefiero hacerlas antes 
% para contestar la pregunta a y b


% a)
Ap1S = SIM(31, 0, 1, 1);
Ap2S = SIM(31, 0, 1, 2);
Ap1T = TP(31, 0, 1, 1);
Ap2T = TP(31, 0, 1, 2);

% b)
%% funcion I1
n = 1:2:33;

error_TP_I1 = [];

for i = 1:length(n)
error_TP_I1(i) = (0.45 - TP(i, 0, 1, 1));
end

error_SI_I1 = [];

for i = 1:length(n)
error_SI_I1(i) = (0.45 - SIM(i, 0, 1, 1));
end

subplot(2,1,1)
plot(n, error_TP_I1, n, error_SI_I1, n, zeros(length(n)), '--')
title('I1')
xlabel('nodos')
ylabel('Error')
legend('Trapezoide','Simpson')

% function I2

n = 1:2:33;

error_TP_I2 = [];

for i = 1:length(n)
error_TP_I2(i) = ((2/pi) - TP(i, 0, 1, 2));
end

error_SI_I2 = [];

for i = 1:length(n)
error_SI_I2(i) = ((2/pi) - SIM(i, 0, 1, 2));
end

subplot(2,1,2)
plot(n, error_TP_I2, n, error_SI_I2, n, zeros(length(n)), '--')
title('I2')
xlabel('nodos')
ylabel('Error')
legend('Trapezoide','Simpson')

%% functions

function res = TP(n, a, b, f)
v = Trapezoide(n, a, b);
if f == 1
    data = I1(v(1,:));
elseif f == 2
    data = I2(v(1,:));
end
res = dot(data, v(2,:));
end

function res = SIM(n, a, b, f)
v = Simpson(n, a, b);
if f == 1
    data = I1(v(1,:));
elseif f == 2
    data = I2(v(1,:));
end
res = dot(data, v(2,:));
end

function y = I1(x)
y = x.^4 + x.^3;
end

function y = I2(x)
y = sin(sqrt((x*pi).^2));
end

function Values = Trapezoide(n, a, b)    
Points = linspace(a, b, n);
Pond = [];
for i = 1:n
    if i == 1 || i == n
        h = ((b - a)/(n - 1))/2;
    else
        h = ((b - a)/(n - 1));
    end
    Pond(i) = h;
end

Values = [Points; Pond];
end

function Values = Simpson(n, a, b)    
Points = linspace(a, b, n);
Pond = [];
for i = 1:n
    if i == 1 || i == n
        h = ((b - a)/(n - 1))/3;
    elseif rem(i,2) == 0
        h = 4*((b - a)/(n - 1))/3;
    else
        h = 2*((b - a)/(n - 1))/3;
    end
    Pond(i) = h;
end

Values = [Points; Pond];
end