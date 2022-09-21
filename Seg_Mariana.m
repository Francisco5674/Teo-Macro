%% seguimiento Mariana 
clear;
clc;

phi = 0.9;
x0 = 100;
y0 = 101;
% no errors
% standar desv equal to 1
vqgm1 = [];
vqgm2 = [];
e = randn(500,1);

for n = 1:500
    vqgm1 = [vqgm1, x0];
    vqgm2 = [vqgm2, y0];
    x1 = phi * x0 + e(n);
    x0 = x1;
    y1 = phi * y0 + e(n);
    y0 = y1;
end
% a)
plot(vqgm1)
% b)
IRF = vqgm2 - vqgm1;
% c)
plot(IRF)
title("IRF phi = 0.9")
%% d)
phi_d = 0.5;
x0 = 100;
y0 = 101;
% no errors
% standar desv equal to 1
vqgm1_d = [];
vqgm2_d = [];
e = randn(500,1);

for n = 1:500
    vqgm1_d = [vqgm1_d, x0];
    vqgm2_d = [vqgm2_d, y0];
    x1 = phi_d * x0 + e(n);
    x0 = x1;
    y1 = phi_d * y0 + e(n);
    y0 = y1;
end
plot(vqgm1_d)
IRF_d = vqgm2_d - vqgm1_d;
%%
pos = 1:500;
plot(pos, IRF_d, pos, IRF)
legend("phi = 0.5", "phi = 0.9")