%%%%%%%%%%%%%%%%%%%%%%%% SVD operation to transmitted data %%%%%%%%%%%%%%
 [U S V]= svd(set,'econ');
 figure(1)
 semilogy(diag(S),'*');
 
 figure(2)
 plot(U(:,1:5),'*');
 X(:,:) = U(:,1:5);
 Y = pdist(X); % Distance information with pdist
 squareform(Y); % Reformatting the distance matrix
 Z = linkage(Y); % the linkage function to generate a hierarchical cluster tree
 %dendrogram(Z,144,'ColorThreshold','default'); 
 dendrogram(Z,169); 
 hold on;
 
 for j = 1: 169;
    y = 0.05;
    plot(j,y,'.r','Linewidth',2)
end
 
 xlabel('Liquid samples')
 ylabel('Height')
 
Y = pdist(X,'cityblock'); 
Z = linkage(Y,'average');
 
c = cophenet(Z,Y) % The cophenetic correlation coefficient
I = inconsistent(Z); % Inconsistancy values
T = cluster(Z,'maxclust',5);

