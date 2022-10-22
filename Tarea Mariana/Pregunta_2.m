clear
clc
%% a)
Data = readtable("Covid.xlsx");

hold on
title("PCR vs Gtcovid Weekly")
yyaxis right
plot(1:80, Data.('Gtcovid'))
ylabel('Gtcovid')
yyaxis left
plot(1:80, Data.('PCR'));
ylabel('PCR')
xlabel('Time')
hold off

%% b)

y = growth(Data.('PCR'));
x = growth(Data.('examen'));
g = growth(Data.('Gtcovid'));

%% c)

[yt,yt_1, yt_2] = Lags(y);
[xt,xt_1, xt_2] = Lags(x);
[gt,gt_1, gt_2] = Lags(g);

% M1 PCR
X1pcr = [yt_1 yt_2];
B1pcr = OLS(X1pcr, yt);

% M2 PCR
X2pcr = [yt_1 yt_2 gt_1 gt_2];
B2pcr = OLS(X2pcr, yt);

% M1 cases
X1cas = xt_1;
B1cas = OLS(X1cas, xt);

% M2 cases
X2cas = [xt_1 xt_2 gt_1 gt_2];
B2cas = OLS(X2cas, xt);

%% d y e)

B1pcr30 = OLS(X1pcr(1:30,:), yt(1:30));
B2pcr30 = OLS(X2pcr(1:30,:), yt(1:30));
B1cas30 = OLS(X1cas(1:30,:), xt(1:30));
B2cas30 = OLS(X2cas(1:30,:), xt(1:30));

% M1pcr rec sch
ypt1pcr = yt(1:30)';
for i= 31:77
    dato = B1pcr30(1) + B1pcr30(2)*yt(i-1) + B1pcr30(3)*yt(i-2);
    ypt1pcr = [ypt1pcr dato];
end

% M2pcr rec sch
ypt2pcr = yt(1:30)';
for i= 31:77
    dato = B2pcr30(1) + B2pcr30(2)*yt(i-1) + B2pcr30(3)*yt(i-2) + ...
        + B2pcr(4)*gt(i-1) + B2pcr30(5)*gt(i-2);
    ypt2pcr = [ypt2pcr dato];
end

% M1cas rec sch
xpt1cas = xt(1:30)';
for i= 31:77
    dato = B1cas30(1) + B1cas30(2)*xt(i-1);
    disp(xt(i-1))
    xpt1cas = [xpt1cas dato];
end

% M2cas rec sch

xpt2cas = xt(1:30)';
for i= 31:77
    dato = B2cas30(1) + B2cas30(2)*xt(i-1) + B2cas30(3)*xt(i-2) +...
        B2cas30(4)*gt(i-1) + B2cas30(5)*gt(i-2);
    xpt2cas = [xpt2cas dato];
end

%%

subplot(2,2,1)
plot(1:77, yt, 1:77, ypt1pcr)
subplot(2,2,2)
plot(1:77, yt, 1:77, ypt2pcr)
subplot(2,2,3)
plot(1:77, xt, 1:77, xpt1cas)
subplot(2,2,4)
plot(1:77, xt, 1:77, xpt2cas)

