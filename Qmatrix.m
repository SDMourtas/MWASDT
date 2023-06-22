function Q=Qmatrix(X,M,D,c,j)
% function for calculating the matrix Q

d=length(D);
if nargin==5
    dd=d-1;
else
    dd=d;
end

Q=zeros(size(X,1),M*d); 
if ~isempty(c)
for i=1:dd
    if c(i)==1
        Q(:,M*(i-1)+1:M*i)=X.^D(i); % Type: power
    elseif c(i)==2
        r=exp(X.^D(i)); % Type: power sigmoid
        Q(:,M*(i-1)+1:M*i)=r./(r+1);
    elseif c(i)==3
        Q(:,M*(i-1)+1:M*i)=exp(-X.^D(i)); % Type: power inverse exponential
    elseif c(i)==4
        r=exp(X.^D(i));
        Q(:,M*(i-1)+1:M*i)=log(1+r); % Type: power softplus
    end
end
end

if nargin==5
    i=dd+1;
    if j==1
        Q(:,M*(i-1)+1:M*i)=X.^D(i); % Type: power
    elseif j==2
        r=exp(X.^D(i)); % Type: power sigmoid
        Q(:,M*(i-1)+1:M*i)=r./(r+1);
    elseif j==3
        Q(:,M*(i-1)+1:M*i)=exp(-X.^D(i)); % Type: power inverse exponential
    elseif j==4
        r=exp(X.^D(i));
        Q(:,M*(i-1)+1:M*i)=log(1+r); % Type: power softplus
    end
end