function Problem_figures(P_train,P_test,X_train,Y_train,X_test,Y_test,E_M,E_V,E_p,p,V,c,M,Z,ZZ,x)

E_p(E_p==inf)=100; P=0.55:0.01:0.85;
figure
semilogy(P,E_p,'DisplayName','Training Error');hold on
semilogy(p,E_p(P==p),'.','Color',[0.8500 0.3250 0.0980],...
        'MarkerSize',16,'DisplayName','Opt. value of p')
xlabel('p');ylabel('MAPE');xlim([P(1) P(end)]);legend;hold off

E_M(E_M==inf)=100;
figure
semilogy(E_M,'DisplayName','Training Error');hold on
semilogy(M,E_M(M),'.','Color',[0.8500 0.3250 0.0980],...
        'MarkerSize',16,'DisplayName','Opt. Delays Num.')
xlabel('M');ylabel('MAPE');xlim([1 length(E_M)]);legend;hold off

figure
semilogy(0:length(E_V)-1,E_V,'DisplayName','Tr. Error')
hold on
if any(c==1)
    v=find(c==1);
    semilogy(V(v),E_V(V(v)+1),'.','Color',[0.8500 0.3250 0.0980],...
        'MarkerSize',16,'DisplayName','AF 1')
end
if any(c==2)
    v=find(c==2);
    semilogy(V(v),E_V(V(v)+1),'.','Color',[0.4660 0.6740 0.1880],...
        'MarkerSize',16,'DisplayName','AF 2')
end
if any(c==3)
    v=find(c==3);
    semilogy(V(v),E_V(V(v)+1),'.','Color',[0.4940 0.1840 0.5560],...
        'MarkerSize',16,'DisplayName','AF 3')
end
if any(c==4)
    v=find(c==4);
    semilogy(V(v),E_V(V(v)+1),'.','Color',[0.9290 0.6940 0.1250],...
        'MarkerSize',16,'DisplayName','AF 4')
end
xlabel('Iteration');ylabel('MAPE');legend;xlim([0 length(E_V)-1]);
hold off

figure
R=length(X_train);
plot(1:R+ZZ,[X_train;Y_train],'Color',[0.4660 0.6740 0.1880])
hold on
plot(R:R+ZZ,[X_train(end);P_train(:,1)],'Color',[0.4940 0.1840 0.5560])
plot(R:R+ZZ,[X_train(end);P_train(:,2)],':','Color',[0.3010 0.7450 0.9330])
plot(R:R+ZZ,[X_train(end);P_train(:,3)],':','Color',[0.8500 0.3250 0.0980])
plot(R:R+ZZ,[X_train(end);P_train(:,4)],'--','Color',[0.9290 0.6940 0.1250])
plot(R:R+ZZ,[X_train(end);P_train(:,5)],'-.','Color',[0.9 0.7 0.8])
legend('Actual','MWASDT','WASDP','LSVM','EGPR','EBT')
xlabel('Time');ylabel('Price')
if x==1 || x==2 || x==4
xticks([1 49 109]); xticklabels({'1991','2003','2018'}); xlim([1 109])
elseif x==3 || x==5
xticks([1 49 93]); xticklabels({'1995','2007','2018'}); xlim([1 93])
elseif x==6
xticks([0 20 56]); xticklabels({'2004','2009','2018'}); xlim([0 56])
end
hold off

figure
R=length(X_test);
plot(1:R+Z,[X_test;Y_test],'Color',[0.4660 0.6740 0.1880])
hold on
plot(R:R+Z,[X_test(end);P_test(:,1)],'Color',[0.4940 0.1840 0.5560])
plot(R:R+Z,[X_test(end);P_test(:,6)],'--','Color',[0.3010 0.7450 0.9330])
plot(R:R+Z,[X_test(end);P_test(:,2)],':','Color',[0 0.4470 0.7410])
plot(R:R+Z,[X_test(end);P_test(:,3)],':','Color',[0.8500 0.3250 0.0980])
plot(R:R+Z,[X_test(end);P_test(:,4)],'--','Color',[0.9290 0.6940 0.1250])
plot(R:R+Z,[X_test(end);P_test(:,5)],'-.','Color',[0.9 0.7 0.8])
legend('Actual','MWASDT','MWASDT WR','WASDP','LSVM','EGPR','EBT')
xlabel('Time');ylabel('Price')
if x==1 || x==2 || x==4
xticks([1 49 109 129]); xticklabels({'1991','2003','2018','2023'}); xlim([1 129])
elseif x==3 || x==5
xticks([1 49 93 113]); xticklabels({'1995','2007','2018','2023'}); xlim([1 113])
elseif x==6
xticks([0 20 56 76]); xticklabels({'2004','2009','2018','2023'}); xlim([0 76])
end
hold off

