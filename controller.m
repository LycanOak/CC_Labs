load('statespace.mat');
load('iodata1.mat');

Ts = mean(diff(ts));
TT=ss(Atrue,Btrue,Ctrue,Dtrue);
TT1=ss(A,B,C,D,Ts);
figure(3);bode(TT);
figure(4);bode(TT1);
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

TTT2=ss(A,B,K,0,Ts);
figure(5);bode(TTT2);
[tlqrn tlqrd]=tfdata(TTT2,'v');
figure(6);zplane(tlqrn,tlqrd);
figure(7);rlocus(TTT2);


TTT3=ss(A-B*K,B*Nbar,C,0,Ts);
figure(8);bode(TTT3);
[tlqen tlqed]=tfdata(TTT3,'v');
figure(9);zplane(tlqen,tlqed);
figure(10);rlocus(TTT3);
% 
% [NC_lqr,DC_lqr] = tfdata(TTT3,'v');
% figure(4);zplane(NC_lqr,DC_lqr)
% figure(5);zplane([],p);
PHIE = A-M*C*A;
GAMMAE = B-M*C*B;

TTT4 = ss([A zeros(size(A)); M*C*A PHIE-GAMMAE*K],[B; M*C*B],[zeros(size(K)) K],0,Ts);
figure(11);bode(TTT4);
[TTn TTd]=tfdata(TTT4,'v');
figure(12);zplane(TTn,TTd);
figure(13);rlocus(TTT4);