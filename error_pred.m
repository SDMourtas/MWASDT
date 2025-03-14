function E=error_pred(X,Y)

E=zeros(7,1);
R=(X-Y)./Y; Z=length(R);
[row,col]=find(isnan(R)); R(row,col)=0;
[row,col]=find(isinf(R)); R(row,col)=0;

yh=mean(Y); % test
SStot=sum((Y-yh).^2);
SSres=sum((X-Y).^2);
E(1)=1-SSres/SStot; % R^2
fprintf('The R-squared is: %f \n',E(1))

E(2)=100/Z*sum(abs(R)); % MAPE
fprintf('The MAPE is: %f \n',E(2))

R=X-Y;

E(3)=100/Z*sum(abs(R)./(abs(X)+abs(Y))); % SMAPE
fprintf('The SMAPE is: %f \n',E(3))

E(4)=sum(abs(R))/Z; % MAE
fprintf('The MAE is: %f \n',E(4))

E(5)=sqrt(sum(R.^2)/Z); % RMSE
fprintf('The RMSE is: %f \n',E(5))

E(6)=(sum(abs(R))/Z)/(sum(abs(Y(2:end)-Y(1:end-1)))/(Z-1)); % MASE
fprintf('The MASE is: %f \n',E(6))

E(7)=sum(sign(Y(2:end)-Y(1:end-1))==sign(X(2:end)-Y(1:end-1)))/(Z-1); % MDA
fprintf('The MDA is: %f \n',E(7))
