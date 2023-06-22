function Q=Qmatrix2(Xz,M,H,A,d)
% function for calculating the matrix Q

Q=zeros(H,M*d);
for i=1:H
    Q(i,:)=reshape(Xz(A+i:A+i+M-1).^(0:d-1),1,[]);
end