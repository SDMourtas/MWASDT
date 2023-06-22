function [Wm2,Mbest2,Vbest2,cbest2,Em2,E_M2,E_VV2,E_p,pbest]=MWASDT(X,Y,vmax)
% function for finding the optimal input-layers number of the neuronet

% M: the neurons number of the input layer (i.e., the number of lagged...
% observations)
% V: the neurons powers of the hidden layers

S=round(length(X)/3); p=0.55:0.01:0.85; len_p=length(p);
E_M=zeros(S,1); E_p=zeros(len_p,1); Em2=inf; Ev=zeros(4,1); 

for j=1:len_p
     Em=inf;
for M=1:S
    % find the optimal hidden-layer neurons weights of the neuronet
    
    V=[]; c=[];  % the neurons number of the hidden layer (i.e., hidneurons)
    E_Mm=inf;    % Initialization
    XY=test_NN(X,Y,M); X1=XY(:,1:end-1); Y1=XY(:,end); E_V=zeros(vmax,1);
    G=length(Y1);
    G1=round(p(j)*G); % size of data fitting
    G2=G-G1;       % size of data validation
    for v=0:vmax-1        
        for i=1:4
            Q=Qmatrix(X1,M,[V;v],c,i);
            W=pinv(Q(1:G1,:))*Y1(1:G1); % WDD Method
            Ev(i)=100/G2*sum(abs((Q(G1+1:end,:)*W-Y1(G1+1:end))./Y1(G1+1:end))); % MAPE
        end
            E_V(v+1)=min(Ev);
        if E_V(v+1)<Em
            r=find(Ev==E_V(v+1));
            E_Mm=E_V(v+1);V=[V;v];c=[c;r(1)];
        end
    end
    Q=Qmatrix(X1,M,V,c);
    W=pinv(Q)*Y1;  % WDD Method
    
    E_M(M)=E_Mm;
    if E_M(M)<Em
        Em=E_M(M);Mbest=M;Wm=W;Vbest=V;cbest=c;E_VV=E_V;
    end
end
    E_p(j)=Em;
    if E_p(j)<Em2
        Em2=E_p(j);Mbest2=Mbest;Wm2=Wm;Vbest2=Vbest;cbest2=cbest;E_VV2=E_VV;E_M2=E_M;pbest=p(j);
    end
end