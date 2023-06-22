function [X_train,Y_train,X_test,Y_test]=problem(x)
% Input data and parameters

GDP={'GDP','UKNGDP','CPMNACSCAB1GQIT','CPMNACSCAB1GQFR','CPMNACSCAB1GQEL','NGDPRNSAXDCINQ'};

c = fred('https://fred.stlouisfed.org/');
c.DataReturnFormat = 'timetable';
d = fetch(c,GDP{x}); d=d.Data{:};
k1=find(d.Time=={'01-Jan-1991'});
k2=find(d.Time=={'01-Jan-2023'});
if isempty(k1) && ~isempty(k2)
    data=d.Var1(1:k2);
elseif isempty(k2) && ~isempty(k1)
    data=d.Var1(k1-1:end);
elseif isempty(k1) && isempty(k2)
    data=d.Var1;
else
    data=d.Var1(k1:k2);
end

Z=20;               % number of forecasting data
G=length(data)-Z;   % total number of observations for training
p=0.7;              % percentage train-test

tr=round(p*G);
X_train=data(1:tr,1); Y_train=data(tr+1:G,1);  % train set
X_test=data(1:G,1); Y_test=data(G+1:G+Z,1);    % test set