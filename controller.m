load('statespace.mat');
load('iodata1.mat');

Ts = mean(diff(ts));
TT=ss(Atrue,Btrue,Ctrue,Dtrue);
TT1=ss(A,B,C,D,Ts);
figure;bode(TT);
figure;bode(TT1);
Q=C'*C;
R=20;
[K,~,p]=dlqr(A,B,Q,R);
% figure(5);
% zplane([],p);
uin=[ts us];


w2 = 100;
QE = eye(size(A))*w2;
RE = 1;
G1 = eye(size(A));

[M,P,GA,q]=dlqe(A,G1,C,QE,RE);

N = inv([A-eye(size(A)), B; C,0])*[zeros(size(A,1),1);1];
Nx = N(1:end-1,:);
Nu = N(end,:);
Nbar = Nu+K*Nx;

sout=sim('regulator');
% T_lqr = ss(A,B,C,0,Ts);
% T2_lqg = ss([A zeros(size(A)); M*C*A P-GA*K],[B; M*C*B],[zeros(size(K)) K],0,Ts);
% C2_lqg = ss([A -B*K; M*C*A P-GA*K-M*C*B*K],[B; M*C*B+GA]*Nbar,[C zeros(size(C))],0,Ts);
% figure;bode(C2_lqg);

% TTT=ss(A,B,C,0,Ts);
% figure(1);bode(TTT);
% 
% TTT2=ss(A,B,K,0,Ts);
% figure(2);bode(TTT2);

% TTT3=ss(A-B*K,B*Nbar,C,0,Ts);
% figure(3);bode(TTT3);
% 
% 
% [NC_lqr,DC_lqr] = tfdata(TTT3,'v');
% figure(4);zplane(NC_lqr,DC_lqr)
% figure(5);zplane([],p);
