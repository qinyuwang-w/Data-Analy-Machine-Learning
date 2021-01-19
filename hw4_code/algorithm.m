function prob = algorithm(q)

% plot and return the probability
load sp500;

p0=[1-0.8 0.8];
A=[0.8 0.2;0.2 0.8]; %good bad
B=[q 1-q; 1-q q];    %+1 -1 
rowsz = size(price_move,1);

%forward procedure
alpha = zeros(rowsz,2);
if price_move(1) == 1
    alpha(1,:) = p0.*B(1,:);
else
    alpha(1,:) = p0.*B(2,:);
end

for i=2:rowsz
    if price_move(i)==1
        alpha(i,:) = (A*alpha(i-1,:)'.*B(1,:)')';
    else
        alpha(i,:) = (A*alpha(i-1,:)'.*B(2,:)')';
    end
end

%backward algorithm
beta = zeros(rowsz,2);
beta(end,:)=1;

for i=(rowsz-1):-1:1
    if price_move(i+1)==1
        beta(i,1) = beta(i+1,1)*A(1,1)*B(1,1) + beta(i+1,2)*A(1,2)*B(1,2);
        beta(i,2) = beta(i+1,1)'*A(2,1)*B(1,1) + beta(i+1,2)'*A(2,2)*B(1,2);
    else
        beta(i,1)=beta(i+1,1)'*A(1,1)*B(2,1) + beta(i+1,2)'*A(1,2)*B(2,2);
        beta(i,2)=beta(i+1,1)'*A(2,1)*B(2,1) + beta(i+1,2)'*A(2,2)*B(2,2);        
    end
end

% gamma calculation
prob = zeros(rowsz,2);
for i=1:size(alpha,1)
    prob(i,:) = (alpha(i,:).*beta(i,:))./sum(alpha(end,:));
end
end