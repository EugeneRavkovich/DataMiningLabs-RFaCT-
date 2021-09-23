function fittedY = WEISBUL(start ,X)
fittedY = start(1)*start(2)*X.^(start(2)-1).*exp(-start(1)*X.^start(2));
end