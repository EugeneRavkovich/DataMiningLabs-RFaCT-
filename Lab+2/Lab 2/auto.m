function [A] = auto(R)
N = length(R);
k_max = N/2;
bot = sum(R.^2)/N;
for k = 1: k_max
    top = 0;
    for i = 1:(N-k+1)
        top = top + R(i)*R(i+k-1);
    end
    top = top/(N-k+1);
    A(k) = top/bot;
end
end