file = fopen('data6.txt', 'r');
X = transpose(fscanf(file, '%g %g', [2 inf]));
scatter(X(:,1), X(:,2), 'filled');

numClasters = 4;
Centers = X(1:numClasters,:);
epsilon = 1e-5;
Qprevious = 1e3;
m = 1;
Q = 999;

while abs(Q - Qprevious) > epsilon
    Qprevious = Q;
    for i = 1:length(X)
        for j = 1:numClasters
            Dist(j) = pdist([X(i,:); Centers(j,:)], 'euclidean');
        end
    [U(i,2), U(i,1)] = min(Dist); 
    end
    
    [Q, claster1, claster2, claster3, claster4] = criterion(X, U);
    
    Centers(1,:) = sum(claster1)/length(claster1);
    Centers(2,:) = sum(claster2)/length(claster2);
    Centers(3,:) = sum(claster3)/length(claster3);
    Centers(4,:) = sum(claster4)/length(claster4);
    
end
figure;
gscatter(X(:,1), X(:,2), U(:,1));
hold on;
plot(Centers(:,1), Centers(:,2), '*');