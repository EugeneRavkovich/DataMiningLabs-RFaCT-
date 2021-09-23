function [res, claster1, claster2, claster3, claster4] = criterion(X, U)
countClaster1 = 1;
countClaster2 = 1;
countClaster3 = 1;
countClaster4 = 1;

for i = 1:length(X)
    if U(i,1) == 1
        claster1(countClaster1, :) = X(i,:);
        countClaster1 = countClaster1 + 1;
    end
    if U(i,1) == 2
        claster2(countClaster2, :) = X(i, :);
        countClaster2 = countClaster2 + 1;
    end
    if U(i,1) == 3
        claster3(countClaster3, :) = X(i, :);
        countClaster3 = countClaster3 + 1;
    end
    if U(i,1) == 4
        claster4(countClaster4, :) = X(i, :);
        countClaster4 = countClaster4 + 1;
    end
end
inner1 = sum(pdist(claster1, 'euclidean'));
inner2 = sum(pdist(claster2, 'euclidean'));
inner3 = sum(pdist(claster3, 'euclidean'));
inner4 = sum(pdist(claster4, 'euclidean'));
res = inner1 + inner2 + inner3 + inner4;
end

