load('statespace.mat');
load('iodata1.mat');

Ts = mean(diff(ts));

Q=transpose(CC)*C;
R=100;
[K,~,p]=dlqr(AA,BB,Q,R);
figure(5);
zplane([],p);
uin=[ts us];


w2 = 100;
QE = eye(size(A))*w2;
RE = 1;
G1 = eye(size(A));

[M,~,~,q]=dlqe(A,G1,C,QE,RE);

N = inv([A-eye(7,7), B; C,0])*[zeros(7,1);1];
Nx = N(1:7,:);
Nu = N(8,:);
Nbar = Nu+K*Nx;

%sout=sim('regulator_2');
sout=sim('regulador_apenas');
T_lqr1 = ss(Atrue,Btrue,Ctrue,Dtrue); 

T_lqr = ss(A,B,C,D,Ts);
figure(6);
bode(T_lqr);
figure(7);
bode(T_lqr1);
%%%pzmap(T_lqr);

