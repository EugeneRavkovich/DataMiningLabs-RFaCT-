file = fopen('data6.txt', 'r');
X = transpose(fscanf(file, '%g %g', [2 inf]));
scatter(X(:,1), X(:,2), '*');

numNeurons = 4;
Centers = X(1:numNeurons,:);
k = 1;
k_max = 10000;
lr = 0.002;
%lr = 0.2     k = 1000 deltaCriterion = 0.0961
%lr = 0.02    k = 344700 deltaCriterion = true 
%lr = 0.002   k = 10063 deltaCriterion = true
%lr = 0.0002  k = 10027 deltaCriterion = true
%lr = 0.00002 k = 10002 deltaCritetion = true
criterionPrev = [0 0];
criterion = [1 1];
epsilon = 1e-5;

while k<=k_max || mean(abs(criterionPrev - criterion))> epsilon 
    criterionPrev = criterion;
    cur = round(1+(length(X)-1)*rand());
    for i = 1:numNeurons
        Dist(i) = pdist([X(cur,:); Centers(i,:)], 'euclidean');
    end
    [U(2), U(1)] = min(Dist);
    for i = 1:length(U(1,:))
        Centers(U(1),i) = Centers(U(1),i) + lr*(X(cur,i) - Centers(U(1),i));
    end
    criterion = Centers(U(1),:);
    k = k + 1;
end


for i = 1 : length(X)
    for j = 1:numNeurons
        newDist(j) = pdist([X(i,:); Centers(j,:)], 'euclidean');
    end
    [G(i,2), G(i,1)] = min(newDist); 

end 

figure
gscatter(X(:,1), X(:,2), G(:,1))
hold on
scatter(Centers(:,1),Centers(:,2),'*')