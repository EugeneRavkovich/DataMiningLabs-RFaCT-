function fittedY = CHISQUARED(start, X)
fittedY = X.^(start/2-1).*exp(-X/2)/2^(start/2)/gamma(start/2);
end