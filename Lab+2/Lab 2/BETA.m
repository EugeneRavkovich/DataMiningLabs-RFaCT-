function fittedY = BETA(start, X)
a = start(1);
b = start(2);
B = gamma(a)*gamma(b)/gamma(a+b);
fittedY = (1/B).*X.^(a-1).*(1-X).^(b-1);
end