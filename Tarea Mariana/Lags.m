function [yt,yt_1,yt_2] = Lags(y)
yt = y;
yt_1 = circshift(y, 1);
yt_2 = circshift(y, 2);
yt = yt(3:end);
yt_1 = yt_1(3:end);
yt_2 = yt_2(3:end);
end

