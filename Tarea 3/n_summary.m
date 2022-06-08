function [out] = n_summary(means, Name)
[Am, Astd, Ap10, Ap50, Ap90, Ap99] = ownsummary(means, 1);

h_text = strcat(Name, " Histogram");
subplot(2,5,1)
hold on 
[t,s] = title(h_text,'tau = 0 -> tau = 0.0133');
h1 = histogram(means(:,1),20, 'Normalization', 'probability');
h2 = histogram(means(:,2),20, 'Normalization', 'probability');
legend('tau = 0', 'tau = 0.0133')
hold off 
subplot(2,5,2)
hold on 
[t,s] = title(h_text,'tau = 0.0267 -> tau = 0.04');
h3 = histogram(means(:,3),20, 'Normalization', 'probability');
h4 = histogram(means(:,4),20, 'Normalization', 'probability');
legend('tau = 0.0267','tau = 0.04')
hold off
subplot(2,5,3)
hold on 
[t,s] = title(h_text,'tau = 0.0533 -> tau = 0.0667');
h5 = histogram(means(:,5),20, 'Normalization', 'probability');
h6 = histogram(means(:,6),20, 'Normalization', 'probability');
legend('tau = 0.0533','tau = 0.0667')
hold off
subplot(2,5,4)
hold on 
[t,s] = title(h_text,'tau = 0.08 -> tau = 0.0933');
h7 = histogram(means(:,7),20, 'Normalization', 'probability');
h8 = histogram(means(:,8),20, 'Normalization', 'probability');
legend('tau = 0.08','tau = 0.0933')
hold off
subplot(2,5,5)
hold on 
[t,s] = title(h_text,'tau = 0.1067 -> tau = 0.12');
h9 = histogram(means(:,9),20, 'Normalization', 'probability');
h10 = histogram(means(:,10),20, 'Normalization', 'probability');
legend('tau = 0.1067','tau = 0.12')
hold off
subplot(2,5,[6 7])
hold on 
[t,s] = title(h_text,'tau = 0 -> tau = 0.12');
h1 = histogram(means(:,1),20, 'Normalization', 'probability');
h10 = histogram(means(:,10),20, 'Normalization', 'probability');
legend('tau = 0','tau = 0.12')
hold off
subplot(2,5,8)
hold on 
plot(linspace(0, 0.12, 10), Am)
title(strcat(Name, " mean"))
xlabel("Sigma")
ylabel("mean")
hold off
subplot(2,5,9)
hold on 
plot(linspace(0, 0.12, 10), Astd)
title(strcat(Name, " standard desv"))
xlabel("Sigma")
ylabel("standard desv")
hold off
subplot(2,5,10)
hold on 
plot(linspace(0, 0.12, 10), Ap50)
title(strcat(Name, " median"))
xlabel("Sigma")
ylabel("median")
hold off
end