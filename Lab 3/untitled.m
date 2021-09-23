file = fopen('data6.txt');
X = transpose(fscanf(file, '%g', [8 inf]));
fclose(file);

for i=1:size(X,2)
    mean_column(i) = mean(X(:,i));
    %std_column(i) = std(X(:,i));
end

std_column = std_per_column(X);

for i=1:size(X,1)
    for j=1:size(X,2)
        X(i,j) = (X(i,j) - mean_column(j))/std_column(j);
    end
end

R = (X'*X)/(size(X,1)-1);

d = 0;
for i=1:(size(R,1))
    for j=i+1:(size(R,1))
        d = d + pow2(R(i,j),2); 
    end
end

chi_squared = chi2inv(0.95, (size(R,1)*(size(R,1)-1))/2);

%Delta - диагональная матрица собственных значений R
%A - искомое преобразование
if d > chi_squared
    [A, Delta] = eig(R);
    %A = fliplr(A);
    Delta = fliplr(flipud(Delta));
    Z = fliplr(X*A);
    %Z = X*A;
    res = sum(std_per_column(Z).^2) - sum(std_per_column(X).^2);
    if res ~= 0
       error()
    end
    alphas = alpha(Delta);
    cov_z = cov(Z);
    scatter(Z(:,1), Z(:,2), 'filled');
end




