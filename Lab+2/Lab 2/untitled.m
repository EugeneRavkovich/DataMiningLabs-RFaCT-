file = fopen("data6.txt");
a = transpose(fscanf(file, '%g %g %g', [3 inf]));
fclose(file);
X = a(:,1);
Y = a(:,2);
sigma = a(:,3);
plot(X, Y)
grid on;
title('y(x)')
xlabel('x')
ylabel('y')

% BETA
start1 = [2, 2];
[Beta1, R1, J1, Covb1, MSE1] = nlinfit(X, Y, @BETA, start1);
resBETA = BETA(Beta1, X);
figure;
plot(X, Y, 'r', X, resBETA, 'b')
title('Y(x) and Beta approximation curve');
xlabel('x');
ylabel('Y(x)')
grid on;

% WEISBUL
start2 = [2, 2];
[Beta2, R2, J2, Covb2, MSE2] = nlinfit(X, Y, @WEISBUL, start2);
resWEISBUL = WEISBUL(Beta2, X);
figure;
plot(X, Y, 'r', X, resWEISBUL, 'b')
title('Y(x) and Weisbul approximation curve');
xlabel('x');
ylabel('Y(x)')
grid on;

%CHISQUARED
start3 = 1;
[Beta3, R3, J3, Covb3, MSE3] = nlinfit(X, Y, @CHISQUARED, start3);
resCHISQUARED = CHISQUARED(Beta3, X);
figure;
plot(X, Y, 'r', X, resCHISQUARED, 'b')
title('Y(x) and Chi Squared approximation curve');
xlabel('x');
ylabel('Y(x)')
grid on;

%CHISQUAREDNORMALIZED
CSN_BETA = CSN(resBETA, Y,sigma, length(Y)-3)
CSN_WEISBUL = CSN(resWEISBUL, Y, sigma, length(Y)-3)
CSN_CHISQUARED = CSN(resCHISQUARED, Y, sigma, length(Y)-2)

%graphs (weighted balances)
gBETA = func(resBETA, Y, sigma);
gWEISBUL = func(resWEISBUL, Y, sigma);
gCHISQUARED = func(resCHISQUARED, Y, sigma);

figure;
plot(X, gBETA)
title('График взвешенных остатков, Бета');
xlabel('х');
ylabel('Взвешенный остаток');
grid on;

figure;
plot(X, gWEISBUL)
title('График взвешенных остатков, Вейсбул');
xlabel('х');
ylabel('Взвешенный остаток');
grid on;

figure;
plot(X, gCHISQUARED)
title('График взвешенных остатков, Хи квадрат');
xlabel('х');
ylabel('Взвешенный остаток');
grid on;

%graps (autocorrelation)
k = 1:length(X)/2;
autoBETA = auto(gBETA);
autoWEISBUL = auto(gWEISBUL);
autoCHISQUARED = auto(gCHISQUARED);

figure;
plot(k, autoBETA)
title('Автокорреляционна функция взвешенных остатков, Бета');
xlabel('k');
ylabel('Ak')
grid on;
    
figure;
plot(k, autoWEISBUL)
title('Автокорреляционна функция взвешенных остатков, Вейсбул');
xlabel('k');
ylabel('Ak')
grid on;

figure;
plot(k, autoCHISQUARED)
title('Автокорреляционна функция взвешенных остатков, Хи квадрат');
xlabel('k');
ylabel('Ak')
grid on;

%доверительные интервалы
ciBETAt = nlparci(Beta1, R1, 'jacobian',J1,'alpha', 0.32);
ciBETAp(1,1) = Beta1(1)+tinv(0.16, 199)*sqrt(Covb1(1,1));
ciBETAp(1,2) = Beta1(1)+tinv(0.84, 199)*sqrt(Covb1(1,1));
ciBETAp(2,1) = Beta1(2)+tinv(0.16, 199)*sqrt(Covb1(2,2));
ciBETAp(2,2) = Beta1(2)+tinv(0.84, 199)*sqrt(Covb1(2,2));

ciWEISBULt = nlparci(Beta2, R2, 'jacobian',J2,'alpha', 0.68);
ciWEISBULp(1,1) = Beta2(1)+tinv(0.16, 199)*sqrt(Covb2(1,1));
ciWEISBULp(1,2) = Beta2(1)+tinv(0.84, 199)*sqrt(Covb2(1,1));
ciWEISBULp(2,1) = Beta2(2)+tinv(0.16, 199)*sqrt(Covb2(2,2));
ciWEISBULp(2,2) = Beta2(2)+tinv(0.84, 199)*sqrt(Covb2(2,2));

ciCHISQUAREDt = nlparci(Beta3, R3, 'jacobian', J3, 'alpha', 0.68);
ciCHISQUAREDp(1) = Beta3+tinv(0.16, 199)*sqrt(Covb3);
ciCHISQUAREDp(2) = Beta3+tinv(0.84, 199)*sqrt(Covb3);