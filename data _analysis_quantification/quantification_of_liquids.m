clc;
clear all;
close all;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%   Reshaping and construction of the matrix %%%%
for i = 1:40;
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
 
 xlabel('Principal Components')
 ylabel('Significance')
 
 included_data_percentage = (S(1,1)+S(2,2)+S(3,3)+S(4,4)+S(5,5))*100/sum(diag(S))
 
 
  %%%%%% Concentration matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Z = [30;35;40;45;50;55;60;65;70;75;80;85;90;95;100;105;110;115;120;125;130;135;140;145;150;155;160;165;170;175;180;185;190;195;200;205;210;215;220;225];
 
%%%%%%%%%%%%%%%%%%%%Truncation has taken as 5
 
%%%%%%%%%%%%%%%%%%%% model matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Original model matrix for transmittance
A = U(:,1:7)\Z;
 
% First and last elements of transmitance
         A2 = U(2:40,1:7)\Z(2:40,:);
         E2 = U(1,1:7)*A2;
         E(1,:)=E2;
 
         A3 = U(1:39,1:7)\Z(1:39,:);
         E3 = U(40,1:7)*A3;
         E(40,:)=E3;
 %Middle elements for transmittance 
for j = 2:39;
        Ut(1:j-1,1:7)=U(1:j-1,1:7);
        Zt(1:j-1,:)=Z(1:j-1,:);
        Ut(j:39,1:7)=U(j+1:40,1:7);
        Zt(j:39,:)=Z(j+1:40,:);
        At = Ut\Zt;
        Et = U(j,1:7)*At;
        E(j,:)= Et;   
end
 
figure(2);
%%%%%%%%% Plot between actual values of Z and E %%%%%%%%%%%%%%%%%%%
plot(Z(1:40,:),E,'*r');
 
px = polyfit(Z,E,1);
vx = polyval(px,Z);
hold on;
%%%%%%%%%%%%%%%%%%%%% Plot of best fit line between Z and E %%%%%%%%%%%
plot(Z,vx,'-','Linewidth',3);
 
 xlabel('Real concentration')
 ylabel('Calculated concentration')
 
hold off;
Y = px(1)*Z+px(2);
 
re = 0;  %initial value of the residual
for k = 1:40;
    c(k) = E(k)-Y(k);
    re = re + c(k);
end;
 
%%%%%%%%%%%%%%%%%%%%%%%%% Finding residuals %%%%%%%%%%%%%%%%%%%%%%%
residuals = re
 
%%%%%%%%%%%%%%%%%%%%%%%%% calculation of the correlation %%%%%%%%%%%%
R = corr2(Z,E)
 
%%%%%%%%%%%%%%%%%%%%%%% plot of residuals against no of data %%%%%%%%%%%
figure(3);
plot(c,'*r');
hold on;
 
for j = 1: 40;
    y = 0;
    plot(j,y,'*b','Linewidth',2)
end
 xlabel('no of data')
 ylabel('Residuals')
 
%%%%%%%%%%%%%%%%%%%%%%% plot of PC1 and PC2 for the liquid characterization
figure(4);
plot(U(:,1),U(:,2),'*g');
 
title('Plot of principle components')
 xlabel('PC1')
 ylabel('PC2')
 histfit(c)
 
 standard_deviation = std(c)
 standard_error = std(c)/sqrt(40)
