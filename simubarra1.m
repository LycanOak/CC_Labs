% Flexible robot link
%--------------------------------------------------------------------
% Loads the true flexible link model
load('barrassmodel.mat')
% Defines experiment parameters
Ts=0.01; % Sampling interval
tfinal=200; %
B=0.1;
f=30
t=0:1/f:tfinal;
u=idinput(length(t),'PRBS',[0 B])
u_in = [t', u]
% Simulates the true model to generate data for identification
sim('barra1');
% Plots the continuous and the discrete time outputs
figure(1)
gg=plot(t,y);
set(gg,'LineWidth',1.5);
gg=xlabel('t (s)');
set(gg,'FontSize',14);
gg=ylabel('y (volt)');
set(gg,'Fontsize',14);
%axis([0 tfinal -4 8]);
hold on
gg=plot(ts,ys,'r');
set(gg,'LineWidth',1.5);
hold off

% Saves data for identification
save('iodata1.mat','us','ys','ts')
% us and ys contain i/o data with a sampling interval of Ts
%---------------------------------------------------------------------
% End of file