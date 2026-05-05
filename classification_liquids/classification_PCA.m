clc;
clear all;
close all;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%   Reshaping and construction of the matrix %%%%
for i = 1:169;
    a = dir('s*.mat.mat');
    load(a(i).name); 
    x= direct.data;
    setk = reshape(x,[1,450000]); %Reshape the transmitted data
    set(i,:)= setk;
end
 
%%%%%%%%%%%%%%%%%%%%%%%% SVD operation to transmitted data %%%%%%%%%%%%%%
 [U S V]= svd(set,'econ');
 figure(1)
 semilogy(diag(S),'*');
 
 xlabel('Principal components')
 ylabel('Significance')
 
 included_data_percentage = (S(1,1)+S(2,2)+S(3,3)+S(4,4)+S(5,5))*100/sum(diag(S))
 %%%%%%%%%%%%%% Plot of PC1 against PC2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 figure(2)
 
 plot3(U(1:30,1),U(1:30,2),U(1:30,3),'*g');
 hold on;
 plot3(U(31:70,1),U(31:70,2),U(31:70,3),'*r');
 hold on;
 plot3(U(71:110,1),U(71:110,2),U(71:110,3),'*k');
 hold on;
 plot3(U(111:145,1),U(111:145,2),U(111:145,3),'*b');
 hold on;
 plot3(U(146:169,1),U(146:169,2),U(146:169,3),'*m');

 grid on;
%title('A plot of principle components of compressed data')
 xlabel('PC1')
 ylabel('PC2')
 zlabel('PC3')
 box on;

