function [m, std, p10, p50, p90, p99] = ownsummary(vector, i)
m = mean(vector, i);
std = sqrt(var(vector, 0, i));
p50 = prctile(vector, 50, i);
p10 = prctile(vector, 10, i);
p90 = prctile(vector, 90, i);
p99 = prctile(vector, 99, i);
end

