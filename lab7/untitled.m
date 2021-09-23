clear all;
clc;
file = fopen('Learning_data6.txt', 'r');
LX = fscanf(file,'%g', [8 inf]);
fclose(file);

file = fopen('PCA_data6.txt', 'r');
X = fscanf(file, '%g', [2 inf]);
fclose(file);

for i = 1:size(LX,1)
    P(i,1) = min(LX(:,i));
    P(i,2) = max(LX(:,i));
end

net = newsom(P, [2,2], 'gridtop');
net.trainParam.epochs = 100;
net = train(net, LX);
Preds = sim(net, LX);
ClasterMap = vec2ind(Preds);

[Xclaster1, Xclaster2, Xclaster3, Xclaster4] = DivideIntoClasters(ClasterMap, X);
figure;
gscatter(X(1,:), X(2,:), ClasterMap);
Xmean(1,:) = mean(Xclaster1);
Xmean(2,:) = mean(Xclaster2);
Xmean(3,:) = mean(Xclaster3);
Xmean(4,:) = mean(Xclaster4);
hold on;
plot(Xmean(:,1), Xmean(:,2), '*');

[LXclaster1, LXclaster2, LXclaster3, LXclaster4] = DivideIntoClasters(ClasterMap, LX);
LXmean(1,:) = mean(LXclaster1);
LXmean(2,:) = mean(LXclaster2);
LXmean(3,:) = mean(LXclaster3);
LXmean(4,:) = mean(LXclaster4);

figure
for i=1:4
    subplot(2, 2, i);
    plot(LXmean(i, :));
    axis([1 8 1 10]);
    subtitle(['Cluster №:',num2str(i)]);
end