function [ class, centroid ] = mykmedoids( pixels, K )

% randomly initialize center
% Select initial medoids randomly
% Iterate while the cost decreases:
%       1.In each cluster, make the point that minimizes the sum of distances
%       within the cluster the medoid
%       2. Reassign each point to the cluster defined by the closest medoid 
%       determined in the previous step.
K = 10;
rowsz = size(pixels,1);
tempcenter = zeros(K,3);
tempcenter_new = zeros(K,3);
for n = 1:K
    tempcenter(n,:) = pixels(randperm(rowsz,3));
end

class = zeros(rowsz,1);
distances = zeros(rowsz,K);
% 

iter = 0;
    tic
while iter < 50
    for i = 1:rowsz
        for j = 1:K
            distances(i,j) = sqrt((pixels(i,1)-tempcenter(j,1))^2+(pixels(i,2)-tempcenter(j,2))^2+(pixels(i,3)-tempcenter(j,3))^2);
                % distances = pixels - repmat(tempcenter(i,:),rowsz,1);?
        end
        % which cluster each point belongs to
        [~,class(i)] = min(distances(i,:));
    end

    for k = 1:K
        % create matrix for 1:k class (matrix changes as k changes)
        pixels_new = pixels(find(class == k),:);
        rowsz_new = size(pixels_new,1);
        sumdist = zeros(rowsz_new,1);
        for r = 1:rowsz_new
            eachpoint = pixels_new(r,:);
            dist_new = abs(repmat(eachpoint,rowsz_new,1) - pixels_new);
            sumdist(r,1) = sum(sum(dist_new,1));
        end
        [~,idx] = min(sumdist);% store the index of the minimal sumdist, discard the value
        tempcenter_new(k,:) = pixels_new(idx,:);
    end             
    
    if tempcenter == tempcenter_new
        break;
    else
        tempcenter = tempcenter_new;
    end
    
    iter = iter + 1;
	%[class, centroid] = kmeans(pixels, K);

end
    toc
centroid = tempcenter;
end

    


