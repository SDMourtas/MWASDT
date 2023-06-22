function Y=predictN(X,M,W,V,c,X_min,X_max,Z,VX,a)
% function for predicting
X_N=Normalization(X,X_min,X_max);

YY=[X_N;zeros(Z,1)];
for i=1:Z
Q=Qmatrix(YY(i:M-1+i)',M,V,c);
Y1=Q*W; Y2=YY(M-1+i); 
if abs(abs(Y1)-abs(Y2))>VX*a
    YY(M+i)=Y2+((Y1>Y2)-(Y1<Y2))*VX*a;
else
    YY(M+i)=Y1; 
end
end
Y_N=YY(end-Z+1:end);

Y=(Y_N+0.5)*(4*X_max-4*X_min)+X_min;