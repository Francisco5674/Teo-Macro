function [out] = f_summary(means, Name)
[Am, Astd, Ap10, Ap50, Ap90, Ap99] = ownsummary(means, 1);

h_text = strcat(Name, " Histogram");
subplot(2,5,1)
hold on 
[t,s] = title(h_text,'rho = 0.9 -> rho = 0.908');
h1 = histogram(means(:,1),20, 'Normalization', 'probability');
h2 = histogram(means(:,2),20, 'Normalization', 'probability');
legend('0.9','0.908')
hold off 
subplot(2,5,2)
hold on 
[t,s] = title(h_text,'rho = 0.917 -> rho = 0.926');
h3 = histogram(means(:,3),20, 'Normalization', 'probability');
h4 = histogram(means(:,4),20, 'Normalization', 'probability');
legend('0.917','0.926')
hold off
subplot(2,5,3)
hold on 
[t,s] = title(h_text,'rho = 0.935 -> rho = 0.944');
h5 = histogram(means(:,5),20, 'Normalization', 'probability');
h6 = histogram(means(:,6),20, 'Normalization', 'probability');
legend('0.935','0.944')
hold off
subplot(2,5,4)
hold on 
[t,s] = title(h_text,'rho = 0.953 -> rho = 0.962');
h7 = histogram(means(:,7),20, 'Normalization', 'probability');
h8 = histogram(means(:,8),20, 'Normalization', 'probability');
legend('0.953','0.962')
hold off
subplot(2,5,5)
hold on 
[t,s] = title(h_text,'rho = 0.971 -> rho = 0.98');
h9 = histogram(means(:,9),20, 'Normalization', 'probability');
h10 = histogram(means(:,10),20, 'Normalization', 'probability');
legend('0.971','0.98')
hold off
subplot(2,5,[6 7])
hold on 
[t,s] = title(h_text,'rho = 0.9 -> rho = 0.98');
h1 = histogram(means(:,1),20, 'Normalization', 'probability');
h10 = histogram(means(:,10),20, 'Normalization', 'probability');
legend('0.9','0.98')
hold off
subplot(2,5,8)
hold on 
plot(linspace(0.1, 0.19, 10), Am)
title(strcat(Name, " mean"))
xlabel("rho")
ylabel("mean")
hold off
subplot(2,5,9)
hold on 
plot(linspace(0.1, 0.19, 10), Astd)
title(strcat(Name, " standard desv"))
xlabel("rho")
ylabel("standard desv")
hold off
subplot(2,5,10)
hold on 
plot(linspace(0.1, 0.19, 10), Ap50)
title(strcat(Name, " median"))
xlabel("rho")
ylabel("median")
hold off
end

