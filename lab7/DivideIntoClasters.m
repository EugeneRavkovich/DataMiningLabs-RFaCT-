function [claster1, claster2, claster3, claster4] = DivideIntoClasters(ClasterMap, X)
countClaster1 = 1;
countClaster2 = 1;
countClaster3 = 1;
countClaster4 = 1;
X = transpose(X);
for i = 1: length(X)
    if ClasterMap(i) == 1
        claster1(countClaster1,:) = X(i,:);
        countClaster1 = countClaster1 + 1;
    end
    if ClasterMap(i) == 2
        claster2(countClaster2,:) = X(i,:);
        countClaster2 = countClaster2 + 1;
    end
    if ClasterMap(i) == 3
        claster3(countClaster3,:) = X(i,:);
        countClaster3 = countClaster3 + 1;
    end
    if ClasterMap(i) == 4
        claster4(countClaster4,:) = X(i,:);
        countClaster4 = countClaster4 + 1;
    end
end

