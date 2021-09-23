function res = CSN(f, y, sigma, v)
res = sum(((f-y)./sigma).^2);
res = res/v;
end