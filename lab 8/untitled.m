clear all;
clc;
[X, Y] = meshgrid(-30:0.2:30, -30:0.2:30);
Z = func(X, Y);
mesh(X, Y, Z);
Zglobalmin = min(min(Z));
%%%%%%%%%%%%% simple stochastic
N = 200000;
M = 2;
from = -30;
to = 30;
ksi = rand(N, M);

for i=1:N
    for j=1:M
        randomPoints(i,j) = from + (to - from)*ksi(i,j);
    end
end

[simpleMinValue, index] = min(func(randomPoints(:,1), randomPoints(:,2)));
simplePoints = randomPoints(index,:);
%%%%%%%%%%%% simulated annealing
T = 50;
T0 = 0.001;
v = 0.99;
x0 = [from + (to - from)*rand() from + (to - from)*rand()];

xCurrent = x0;
l = 0;
while T>T0
    l = l + 1;
    z = randn(1,2);
    ksi = rand(1,2);
    repeat = false;
    for i=1:2
        xNext(i) = xCurrent(i) + z(i)*T*((1+l/T)^(2*ksi(i)-1)-1);
        if(xNext(i) > to || xNext(i) < from)
            repeat = true;
        end
    end
    if(repeat)
        continue;
    end
    
    Zcurrent = func(xCurrent(1), xCurrent(2));
    Znext = func(xNext(1), xNext(2));
    delta = Znext - Zcurrent;
    if(delta < 0)
        xCurrent = xNext;
    else
        P = exp(-delta/T);
        if(rand()<P)
            xCurrent = xNext;
        else
            T = v*T;
        end
    end 
end

annealingPoints = xCurrent;
annealingMinValue = func(xCurrent(1), xCurrent(2));


disp("Координаты глобольного минимума: 0 0");
disp("Значение функции в точке глобального минимума: " + num2str(Zglobalmin));
disp("Простой стохастический поиск");
disp("Координаты глобального минимума: " + num2str(simplePoints));
disp("Значение функции в координатах " + num2str(simpleMinValue));
disp("Метод имитации отжига");
disp("Координаты глобального минимума: " + num2str(annealingPoints));
disp("Значение функции в координатах " + num2str(annealingMinValue));
