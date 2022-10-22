clear;
clc;

%% a)
X_to_A([1, 1, -7, 2; 0, 4, 2, -4; 3, 0, 2, -6; -2, -3, 8, 3])


%% b)
A = [-7, 1, 1, 2; 0, 4, 2, -1; 3, 0, -6, 2; -2, -3, 3, 8];
LDU = desmat(A);
LDU(:,:,3)
% LDU is a tridimensional matrix where the first matrix is L, the second is
% D and the last one is U.

%% c)
tol = 10^-6;
b = [17, 28, 19, 10]';
[Sol1, E1, ev1] = MatrixSolve(A, b, tol);

%% d) 
Sol2 = LoopSolve(A, b, tol);

%% e)

Eabs1 = E1 + Sol1;

subplot(2,2,1)
plot(ev1)
title('Num Error')
subplot(2,2,2)
plot(1:15,E1(1,:),1:15,E1(2,:),1:15,E1(3,:),1:15,E1(4,:))
legend('x1','x2','x3','x4')
title('Error')
subplot(2,2,3)
plot(1:15,Eabs1(1,:),1:15,Eabs1(2,:),1:15,Eabs1(3,:),1:15,Eabs1(4,:))
legend('x1','x2','x3','x4')
title('Abs Error')
%% functions
function Res = X_to_A(A1)
Res = [-7, 1, 1, 2; 0, 4, 2, -1; 3, 0, -6, 2; -2, -3, 3, 8]; 
end

function LDU = desmat(A)
D = diag(diag(A));
L = tril(A) - D;
U = A - L - D;

LDU(:,:,1) = L;
LDU(:,:,2) = D;
LDU(:,:,3) = U;
end

function [Sol, E, ev] = MatrixSolve(A, b, tol)
LDU = desmat(A);
L = LDU(:,:,1);
D = LDU(:,:,2);
U = LDU(:,:,3);

% empty vector to save errors
E = [];
ev = [];


x0 = zeros(size(A,1),1);
disp(x0);
x1 = (L + D)\(b - U*x0);
e = abs(norm(x1) - norm(x0));
while e > tol
    x2 = (L + D)\(b - U*x1);
    e = abs(norm(x1) - norm(x2));
    E = [E, x1 - x2];
    ev = [ev, e];
    x1 = x2;
end
Sol = x2;
end

function Sol = LoopSolve(A, b, tol)
Sol = zeros(size(A,1),1);
x2 = zeros(size(A,1),1);
x1 = zeros(size(A,1),1);
x0 = zeros(size(A,1),1);

x1(1) = (1/A(1,1))*(b(1) - A(1,2)*x0(2) - A(1,3)*x0(3) - A(1,4)*x0(4) );
x1(2) = (1/A(2,2))*(b(2) - A(2,1)*x1(1) - A(2,3)*x0(3) - A(2,4)*x0(4) );
x1(3) = (1/A(3,3))*(b(3) - A(3,1)*x1(1) - A(3,2)*x1(2) - A(3,4)*x0(4) );
x1(4) = (1/A(4,4))*(b(4) - A(4,1)*x1(1) - A(4,2)*x1(2) - A(4,3)*x1(3) );

e = abs(norm(x0) - norm(x1));
while e > tol
 x2(1) = (1/A(1,1))*(b(1) - A(1,2)*x1(2) - A(1,3)*x1(3) - A(1,4)*x1(4) );
 x2(2) = (1/A(2,2))*(b(2) - A(2,1)*x2(1) - A(2,3)*x1(3) - A(2,4)*x1(4) );
 x2(3) = (1/A(3,3))*(b(3) - A(3,1)*x2(1) - A(3,2)*x2(2) - A(3,4)*x1(4) );
 x2(4) = (1/A(4,4))*(b(4) - A(4,1)*x2(1) - A(4,2)*x2(2) - A(4,3)*x2(3) );
 e = abs(norm(x1) - norm(x2));
 x1 = x2;
end
Sol = x2;
end


