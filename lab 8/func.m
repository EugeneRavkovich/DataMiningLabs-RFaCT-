function [r] = func(x,y)
    res = 20 - 20*exp(-sqrt(0.2*(x.^2+y.^2))) - exp(0.5*(cos(2*pi*x)+cos(2*pi*y))) + exp(1);
    r = double(res);
end

