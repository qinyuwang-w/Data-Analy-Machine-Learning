function [ class, centroid ] = mykmeans( pixels, K )

rowsz = size(pixels,1);

% InitilizaCentroids
tempcenter = zeros(K,3);
% tempcenter_new = zeors(K,3);
for n = 1:K
    tempcenter(n,:) = randperm(255,3);  % randomly assign K center
end
class = zeros(rowsz,1);
distances = zeros(rowsz,K);
iter = 0;
    tic
while iter < 50    
% AssignCentroids (iteration step1)
    for i = 1:rowsz
        for j = 1:K
            % RBG channel 3D distance
            distances(i,j) = sqrt((pixels(i,1)-tempcenter(j,1))^2+(pixels(i,2)-tempcenter(j,2))^2+(pixels(i,3)-tempcenter(j,3))^2);
        end
        % store the index of min_distance to each cluster
        [~,class(i)] = min(distances(i,:));
    end

% ComputeCentroid(iteration step2)
    for k = 1:K
        tempcenter_new(k,:) = mean(pixels(find(class == k),:));        
    end
% update or adjust    
    if tempcenter == tempcenter_new
        break;
    else
        tempcenter = tempcenter_new;
    end
    iter = iter + 1;
end
    toc
% centroids: number of colors
centroid = round(tempcenter);   % double to integer
end