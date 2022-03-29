%% Seguimiento 3
% los parametros son
sigma = 1;
beta = 0.96;
y1 = 5;
y2 = 7;
r = 0.03;

% b) con la funcion creada usamos fsolve

S = fsolve(@(s) euler(beta, y1, y2, r, s), 0);

c1 = y1 - S;
c2 = y2 + (1 + r)* S;

% los resultados son identicos a los encontrados en a)

%% d) problema con incertidumbre
y2_1 = 10;
y2_2 = 4;
y2_3 = 1;

S_in = fsolve(@(s) euler_es(beta, y1, y2_1, y2_2, y2_3, r, s), 0);

c1_in = y1 - S_in;
c2_in_1 = y2_1 + (1 + r)* S_in;
c2_in_2 = y2_2 + (1 + r)* S_in;
c2_in_3 = y2_3 + (1 + r)* S_in;
% en efecto, existe ahorro precautiorio, es mas, pasamos de endeudarnos a
% ahorrar.

%% las funciones se crean primero, claramente

function U = euler(beta, y1, y2, r, s)
U = (1 + r)* beta* (y1 - s) - (y2 + (1 + r)* s)  ;
end

function U = euler_es(beta, y1, y2_1, y2_2, y2_3, r, s)
U = (1 + r)* beta*...
    (0.6/(y2_1 + (1 + r)* s) +...
    0.2/(y2_2 + (1 + r)* s) +...
    0.2/(y2_3 + (1 + r)* s))...
    - (1 / (y1 - s))  ;
end