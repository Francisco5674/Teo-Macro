%% Primero declaramos las variables necesarias

%% a)
s = 1000;
X1 = 1 + (8-1)*rand(s,1);
X2 = randn(s,1)*2 + 3;

X3 = randn(s,1).^2;
for i = 1:99
    X3 = X3 + randn(s,1).^2;
end

X4 = randn(s,1)./( (randn(s,1).^2 + randn(s,1).^2) /2).^0.5;

u = rand(s,1); 
X5 = (u>0.5).*X2 + (1-(u>0.5)).*X3;

X6 = (X4 + X5)*(0.5) + 0.1 * randn(s,1);

Y = -(1/0.6)*log(1-rand(s,1));

X = [X1 X2 X3 X4 X5 X6];

subplot(2,3,1)
histogram(X1,40);
title('X1');

subplot(2,3,2)
histogram(X2,40);
title('X2');

subplot(2,3,3)
histogram(X3,40);
title('X3');

subplot(2,3,4)
histogram(X4,40);
title('X4');

subplot(2,3,5)
histogram(X5,40);
title('X5');

subplot(2,3,6)
histogram(X6,40);
title('X6');


%% b)

% sacamos las muestras de X
SX = Data_sample(1000, 100, X);

% muestras de Y
SY = Data_sample(1000, 100, Y);

%% c)

%% d)
media = mean(SX,1);
mediana = prctile(SX, 50, 1);
mini = min(SX);
maxi = max(SX);
vari = var(SX);
pc_25 = prctile(SX, 25, 1);
pc_75 = prctile(SX, 75, 1);

% creamos los valores 1 para el coeficiente de posicion y estimamos OLS
aux = ones(100, 1, 1000);

% juntamos los unos con los datos
SX_est = [aux  SX];

% usamos la funcion betas
betas = Betas(SX_est, SY); 

% verificamoos para los primeros betas y vemos que ambos metodos dan el
% mismo resultado
lr = fitlm(SX(:, :, 1), SY(:, :, 1));
lr.Coefficients

%% e)
% computamos betas de una muestra cualquiera
betas(:, :, 1)

%% f) la matriz ya existe, se llama beta

%% g) usaremos una funcion  e iteramos con el tamano de las muestras

Data = [];
i = 0;
for s = [10^2 10^3 10^4 10^5]
    i = i + 1;
    Data(i, :, :) = All_betas(1000, s, X, Y); 
end

%% graficamos

n = 0;
figure();
for i = 1: size(Data, 1)
    for j = 1: size(Data, 2)
    n = n + 1;
    subplot(4, 7, n);
    histogram(Data(i, j, :), 100);
    end
end

%% h) iteramos nuevamente con la cantidad de muestras 

Data_n = All_betas(100000, 100, X, Y);

%% graficamos
histogram(Data_n(1, 1, :));

%% usefull functions

% usare matrices de tres dimensiones

function Data = All_betas(n, s, X, Y)
SX = Data_sample(n, s, X);
SY = Data_sample(n, s, Y);
aux = ones(s, 1, n);
SX_est = [aux  SX];

Data = Betas(SX_est, SY); 
end

function B = Betas(X, Y)
B = [];
for i = 1:size(X, 3)
    x = X(:, :, i);
    y = Y(:, :, i);
    B(:, :, i) = (x' * x)\x' * y;
end
end

function Samples = Data_sample(n, s, X)
Samples = [];
for i = 1:n
    % genera cada muestra
    SX = [];
    for i_1 = 1:size(X,2)
        SX(:,i_1) = Sample(s, X(:,i_1)');
    end
% se guarda cada muestra en un objetop tridimensional 
Samples(:,:,i) = SX;
end
end

% saca mvectores que corresponden a muestras de n elementos
function Samp = Sample(n, vector)
Samp = [];
for i = 1:n
Samp(i) = vector(randi(length(vector)));
end
Samp = Samp';
end


