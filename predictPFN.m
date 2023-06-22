function Y=predictPFN(X,L,Z,M,W,x_min,x_max)
% function for forecasting future prices

Xz=Normalization(X,x_min,x_max);

G=length(Xz);
H=G-M-L+1;     % previous samples
N=length(W)/M; % the neurons number of the hidden layer (i.e., hidneurons)
YY=Xz(1:G);YY(G+1:G+Z)=0;
for i=1:Z
Q=Qmatrix2(YY,M,i,H,N);
YY(G+1:G+i)=Q*W;
end
Y_N=YY(G+1:G+Z);

Y=(Y_N+0.5)*(4*x_max-4*x_min)+x_min;

k=find(isnan(Y));
if ~isempty(k)
    for i=1:length(k)
        Y(k(i))=Y(k(i)-1);
    end
end
[m,n]=size(Y);
if m<n
    Y=Y';
end