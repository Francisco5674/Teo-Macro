function g = growth(serie)
serie_t = serie;
serie_t_1 = circshift(serie, 1);
serie_t_1 = serie_t_1(2:end);
serie_t = serie_t(2:end);
g = log(serie_t) - log(serie_t_1);
end

