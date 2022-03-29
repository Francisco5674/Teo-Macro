%% Seguimiento 1

% todo fue creado en función de las distribuciones originales del 
% seguimiento, por ende, puede que existan tiempos negativos, sin embargo
% el objetivo principal de la actividad se cumple sin problemas
clear;
people = 1000;
days = 30;

% Utilizando loops, cree la matriz TL1 que contiene 
% como fila a cada cliente y como columna el
% tiempo de total de compra del mismo cliente 
% para cada d ́ıa del mes de abril

% para este proceso creamos los siguientes datos

getin = -(1/2)*log(1-rand(people,days));

looking = randn(people,days) + 0.3;

pay = randn(people,days)*0.2 + 0.15;

%% a. matriz TL

N = 1;

TL = zeros(people,days);

while N < days + 1
    TL(:,N) = getin(:,N) + looking(:,N) + pay(:,N);
    N = N + 1;
end

%% b. matriz TM

TM = getin + looking + pay;
% TM y TL son identicas

%% c. max

[row,col] = find(TM == max(max(TM)));
disp("la persona es la que tiene el mayor tiempo de compra es la:")
disp(row)
disp("y su tiempo fue de:")
disp(max(max(TM)));

%% d. min

[row,col] = find(TM == min(min(TM)));
disp("la persona es la que tiene el menor tiempo de compra es la:")
disp(row)
disp("y su tiempo fue de:")
disp(min(min(TM)));

%% e. funtion

[VL, Pmx, mx, Pmi, mi] = test(5, 10)


function [VL, Pmx, mx, Pmi, mi] = test(people, days)
    in = -(1/2)*log(1-rand(people,days));

    look = randn(people,days) + 0.3;
    
    p = randn(people,days)*0.2 + 0.15;

    N = 1;

    TL = zeros(people,days);
    
    while N < days + 1
        TL(:,N) = in(:,N) + look(:,N) + p(:,N);
        N = N + 1;
    end

    total_time = sum(TL,2);

    VL = total_time;

    [Pmx, aux] =  find(TL == max(max(TL)));
    [Pmi, aux] =  find(TL == min(min(TL)));
    mx = max(max(TL));
    mi = min(min(TL));

end






