% [X,Y] = meshgrid(-5:.5:5,-5:.5:5);
% %Z = X.^5 + Y.^5;
% Z = X.^2 + Y.^2;
% surf(X,Y,Z)

% Example:
% X = flow rate [0.1 1]*1E-4 m3/s
% Y = temperature [300 500] K
% Z = film thickness [100 400]*1E-9 m
[X,Y] = meshgrid(0.1:.5:5,-5:.5:5);

numberOfVariables = 2;

dim = size(Z);
numberOfPoints = dim(1)^2;

points = zeros (numberOfPoints, numberOfVariables);

for i = 1:numberOfPoints
    points(i,1) = X(i);
end

for i = 1:numberOfPoints
    points(i,2) = Y(i);
end

for i = 1:numberOfPoints
    points(i,3) = Z(i);
end

[coeff,score,latent,tsquared,explained] = pca(points);



    
