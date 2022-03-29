%% Vectores y Matrices
clc; 
clear; 
close all;

%1. Genere tres variables escalares%
a = 1;
b = 8;
c = 10;
%% 2. Genere vector fila y su traspuesta%
v1=[a b c];
v2 = v1';
v2_1 = [a;b;c];

%% 3. Vector z1 y z2 con 51 puntos equidistantes entre 0 y 100.

z1 = linspace(2,100); 
z1_b = 1:100; %crea la variable con números del 1 al 100
z1_c = 1:1:100;%crea la vaclc


%% 4. Genere una matriz V3
V3 = [1 2 3;2 16 20;a b c;3 2 1];

f1 = 1:3;
f2 = 2*v1;
f3 = v1; %v1 = [a b c] = [1 8 10]
f4 = flip(f1); %B = flip(A) returns array B the same size as A, but ...
%with the order of the elements reversed.
V3_2 = [f1; f2; f3; f4];

Vf = max(V3);

Vs = sum(V3);


%% 5. Matrices 4×4 V4,V5,V6 y V7 que sean: ceros, unos, identidad, ochos
V4 = zeros(4);
V5 = ones(4);
V6 = eye(4);
V7 = 8*ones(4);


%% 6. Sub-conjuntos
A = V3(3,2);
B = V3(:,3);
C = V3(2,:);
D = V3(2:5,1:2);
E = V3(V3>=3)';


%% 7. 
V3(2,3) = -5;
V3(2:4,2) = v1;


%% 8. Cantidad de filas y columnas de V3
fil = size(V3,1);
col = size(V3,2);


%% 9. Va = [V3 V3 V3]
Va = [V3 V3 V3];
Va2 = repmat(V3,1,3); %B = repmat(A,n) returns an array containing ...
%n copies of A in the row and column dimensions.


%% 10. 
disp('Número de elementos de V3 mayores o iguales a 3')
disp(sum(sum( V3>=3 )))

Vc= V3.*(V3>=3);

Vd= V3;
Vd(Vd<3)= NaN;


%% 11.
P1= v1'*v1; %Matriz
P2= v1*v1'; %Escalar
P3= v1.*v1; %Vector
% Ver variables P en workspace
V8= V3.*v1; 



%% Pregunta 2 - Distribución de probabilidad

clc; clear ;close all

r= 10000; %filas
c= 1;    %columnas

%In general, you can generate N random numbers in the interval (a,b) ...
%with the formula r = a + (b-a).*rand(N,1).
X1 = 1 + (4-1)*rand(r,c);


%% 2.

X2 = randn(r,c).^2 + randn(r,c).^2 + randn(r,c).^2;
%X2: chi cuadrado con 3 grados de libertad, es la suma de variables
%normales al cuadrado




df= 100; %Grados de libertad
iter = 1;
% Primera forma
X2_1= randn(r,c).^2;

while iter < df
    aux = randn(r,c).^2;
    X2_1 = X2_1 + aux;
    
    iter = iter + 1;
end

% Segunda forma
X2_2= sum(randn(r,df).^2,2); %sum(matriz,2), suma por fila.

% Histograma
X2aux= [X2_1 X2_2];

subplot(1,2,1)
histogram(X2aux(:,1))

subplot(1,2,2)
histogram(X2aux(:,2))

%% 3.T-student

X3= randn(r,c)./( (randn(r,c).^2 + randn(r,c).^2) /2).^0.5; %t-student 2...
%grados de libertad


%% 4. N(5,1.5)

X4 = randn(r,c)*1.5 + 5; 


%% 5.  Mixtura
u = rand(r,c); 

X5 = (u>0.5).*X3 + (1-(u>0.5)).*X4; 
%X5= (u>0.5).*X3 + (u<=0.5).*X4; 

%% 6. Promedio

X6 = (X4+X5)/2 + randn(r,c)*0.001;

%% 7. exp(x)

X7 = -(1/0.2)*log(1-rand(r,c));

%% 7. Plot
tx = {'Interpreter','Latex','FontSize', 17};


Mx = [X1 X2 X3 X4 X5 X6 X7];

for i = 1 : size(Mx,2)
    dist_names = {'Uniform','$\chi^{2}$','$t_{student}$','Normal',...
        'Mix','Average','Exponential'};
    
    figure(1)
    subplot (2,4,i)
    histogram(Mx(:,i))
    title(dist_names(i),tx{:})
    
end


% figure(2) 
% sgtitle('Distribucion de probabilidad',tx{:},'FontSize', 15)
% subplot(3,2,1) %3 filas, 2 columnas, "1" posición en la imagen.
% histogram(X1,100)
% title('$X_1$',tx{:})
% 
% subplot(3,2,2)
% histogram(X2,100)
% title('$X_2$',tx{:})
% 
% subplot(3,2,3)
% histogram(X3,100)
% title('$X_3$',tx{:})
% 
% subplot(3,2,4)
% histogram(X4,100)
% title('$X_4$',tx{:})
% 
% subplot(3,2,5)
% histogram(X5,100)
% title('$X_5$',tx{:})
% 
% subplot(3,2,6)
% histogram(X6,100)
% title('$X_6$',tx{:})


%% Funciones


