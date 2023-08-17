%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  A 3-layer feed-forward neuronet model for time-series modeling   %
%  and forecasting problems, trained by a MWASDT algorithm.         %
%  (version 1.0)                                                    %
%                                                                   %
%  Developed in MATLAB R2022a                                       %
%                                                                   %
%  Author and programmer: S.D.Mourtas, E.Drakonakis, Z.Bragoudakis  %
%                                                                   %
%   e-Mail: spirmour@econ.uoa.gr, emdrakon@econ.uoa.gr              %
%           Zbragoudakis@bankofgreece.gr                            %
%                                                                   %
%   Main paper: S.D.Mourtas, E. Drakonakis and Z. Bragoudakis,      %
%               "Forecasting the Gross Domestic Product using a     %
%               weight direct determination neural network",        %
%               AIMS Mathematics, 8(10), 24254-24273, 2023          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

% Choose forecasting problem (for x = 1 to 6)
x=1;
[X_train,Y_train,X_test,Y_test]=problem(x);
vmax=50;          % maximum power of hidden-layer neurons
Z=length(Y_test); % number of forecasting prices

%% Training
% Data Preprocessing: Normalization
[XY_N,X_min,X_max]=Normalization([X_train;Y_train]); 
X_N=XY_N(1:length(X_train));
Y_N=XY_N(length(X_train)+1:end);

% Neuronet models Training
tic
[W,M,V,c,Em,E_M,E_V,E_p,p]=MWASDT(X_N,Y_N,vmax); % optimal structure of the MWASDT Neuronet
toc

Xz=[X_N;Y_N]; G=length(Xz); 
T=G-round(p*G); L=1;
tic
M2=WASD(Xz,G,T,L,vmax);         % optimal structure of the PFN
W2=OHLW(Xz,G-T,L,M2,vmax);      % optimal hidden-layer structure
toc

X=test_NN(X_train,Y_train,M);
tic
TM_LSVM = LSVM(X); % Linear SVM model
toc
tic
TM_EGPR = EGPR(X); % Exponential GRP model
toc
tic
TM_EBT = EBT(X);   % Ensemble Bagged Trees model
toc

%% Predict
VX=var(X_N); X_tr=X_train(end-M+1:end); X_te=X_test(end-M+1:end); ZZ=length(Y_train);

% Predict of train data
pred1_tr=predictN(X_tr,M,W,V,c,X_min,X_max,ZZ,VX,inf);
pred2_tr=predictPFN(X_train(end-M2+1:end),L,ZZ,M2,W2,X_min,X_max);
pred3_tr=predictNN(X_tr,TM_LSVM,M,ZZ);
pred4_tr=predictNN(X_tr,TM_EGPR,M,ZZ);
pred5_tr=predictNN(X_tr,TM_EBT,M,ZZ);

% Error of train data
E_tr=zeros(7,5);
fprintf('MWASDT model statistics on train data: \n')
E_tr(:,1)=error_pred(pred1_tr,Y_train);  
fprintf('WASDP model statistics on train data: \n')
E_tr(:,2)=error_pred(pred2_tr,Y_train); 
fprintf('LSVM model statistics on train data: \n')
E_tr(:,3)=error_pred(pred3_tr,Y_train); 
fprintf('EGPR model statistics on train data: \n')
E_tr(:,4)=error_pred(pred4_tr,Y_train); 
fprintf('EBT model statistics on train data: \n')
E_tr(:,5)=error_pred(pred5_tr,Y_train); 

% Predict of test data
if x==3,gamma=1;else, gamma=10;end
pred1=predictN(X_te,M,W,V,c,X_min,X_max,Z,VX,gamma);
pred2=predictPFN(X_test(end-M2+1:end),L,Z,M2,W2,X_min,X_max);
pred3=predictNN(X_te,TM_LSVM,M,Z);
pred4=predictNN(X_te,TM_EGPR,M,Z);
pred5=predictNN(X_te,TM_EBT,M,Z);
pred6=predictN(X_te,M,W,V,c,X_min,X_max,Z,VX,inf);

% Error of test data
E_te=zeros(7,6);
fprintf('MWASDT model statistics on test data: \n')
E_te(:,1)=error_pred(pred1,Y_test);  
fprintf('WASDP model statistics on test data: \n')
E_te(:,2)=error_pred(pred2,Y_test); 
fprintf('LSVM model statistics on test data: \n')
E_te(:,3)=error_pred(pred3,Y_test); 
fprintf('EGPR model statistics on test data: \n')
E_te(:,4)=error_pred(pred4,Y_test); 
fprintf('EBT model statistics on test data: \n')
E_te(:,5)=error_pred(pred5,Y_test); 
fprintf('MWASDT WR model statistics on test data: \n')
E_te(:,6)=error_pred(pred6,Y_test);  

%% Figures
P_train=[pred1_tr,pred2_tr,pred3_tr,pred4_tr,pred5_tr];
P_test=[pred1,pred2,pred3,pred4,pred5,pred6];

Problem_figures(P_train,P_test,X_train,Y_train,X_test,Y_test,E_M,E_V,E_p,p,V,c,M,Z,ZZ,x)
