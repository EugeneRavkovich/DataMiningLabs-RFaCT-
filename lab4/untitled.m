file = fopen('data6.txt', 'r');
X = transpose(fscanf(file, '%g %g', [2 inf]));

figure
plot(X(:,1),X(:,2), '*');

EuclidianDist = pdist(X, 'euclidean');
CityBlockDist = pdist(X, 'cityblock');
MinkowskiDist = pdist(X, 'minkowski', 4);

EuclidianSingle = linkage(EuclidianDist, 'single');
EuclidianCentroid = linkage(EuclidianDist, 'centroid');
EuclidianMedian = linkage(EuclidianDist, 'median');

CityBlockSingle = linkage(CityBlockDist, 'single');
CityBlockCentroid = linkage(CityBlockDist, 'centroid');
CityBlockMedian = linkage(CityBlockDist, 'median');

MinkowskiSingle = linkage(MinkowskiDist, 'single');
MinkowskiCentroid = linkage(MinkowskiDist, 'centroid');
MinkowskiMedian = linkage(MinkowskiDist, 'median');

Cophenet(1,1) = cophenet(EuclidianSingle, EuclidianDist);
Cophenet(1,2) = cophenet(EuclidianCentroid, EuclidianDist);
Cophenet(1,3) = cophenet(EuclidianMedian, EuclidianDist);

Cophenet(2,1) = cophenet(CityBlockSingle, CityBlockDist);
Cophenet(2,2) = cophenet(CityBlockCentroid, CityBlockDist);
Cophenet(2,3) = cophenet(CityBlockMedian, CityBlockDist);

Cophenet(3,1) = cophenet(MinkowskiSingle, MinkowskiDist);
Cophenet(3,2) = cophenet(MinkowskiCentroid, MinkowskiDist);
Cophenet(3,3) = cophenet(MinkowskiMedian, MinkowskiDist);

% naibolee effectivniy - CityBlockCentroid
% naimenee effectivniy - MinkowskiSingle

figure
dendrogram(CityBlockCentroid);

t = cluster(CityBlockCentroid, 'maxclust', 3);

row1=1;
row2=1;
row3=1;
for i=1:length(t)
     if (t(i) == 1)
        cluster1(row1,:) = X(i,:);
        row1 = row1+1;
     end
     if (t(i) == 2)
        cluster2(row2,:) = X(i,:);
        row2 = row2+1;
     end
     if (t(i) == 3)
        cluster3(row3,:) = X(i,:);
        row3 = row3+1;
     end
end

centers = [mean(cluster1); mean(cluster2); mean(cluster3)];
inner_dispercion = [var(cluster1)*1e3; var(cluster2)*1e3; var(cluster3)*1e3];

figure
gscatter(X(:,1), X(:,2),t);
hold on
plot(centers(:,1), centers(:,2), '*');

% ij - rasstoyanie megdu i j
Cluster1Dist = squareform(pdist([cluster1; mean(cluster1)], 'euclidean'));
Cluster2Dist = squareform(pdist([cluster2; mean(cluster2)], 'euclidean'));
Cluster3Dist = squareform(pdist([cluster3; mean(cluster3)], 'euclidean'));
Cluster1DistToCenter = Cluster1Dist(:,7);
Cluster2DistToCenter = Cluster2Dist(:,7);
Cluster3DistToCenter = Cluster3Dist(:,7);

ClusterCentersDist = pdist(centers, 'euclidean');