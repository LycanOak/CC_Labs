load('iodata1.mat')
% max=0;

Ts = mean(diff(ts)); % Intervalo de amostragem (s)
utrend=us;
ytrend=ys;
figure(1)
plot(utrend)
figure(2)
plot(ys)
af = 0.8;
Afilt = [1 -af];
Bfilt = -(1-af)*[1 -1];
% Filtragem seguida de eliminação de tendências
% Filtering and detrending
yf = filter(Bfilt,Afilt,ytrend);
% u = detrend(utrend);
% figure(1)
% plot(u)
z = [yf utrend];
u2=square(2*pi*0.02*ts);
u_in=[ts u2] ;
sim('barra1');
yf2=filter(Bfilt,Afilt,ys);
z2=[yf2 u2];
fit_arr=[0];
j=1;
max = 0;
% for i=2:8
%     na=i;
%     nk=1;
%     nb=1;
%     while nb<na
%         nc=na;
%         nn = [na nb nc nk];
%         th = armax(z,nn); % th is a structure in identification toolbox format
%         [den1,num1] = polydata(th);
%         yfsim = filter(num1,den1,utrend); % Equivalent to idsim(u,th);
%         figure(j);
%         plot(yfsim);
%         title(['na =' num2str(na) ', nb=' num2str(nb)]);
%         figure(j+1);
%         zplane(num1,den1);
%         title(['na =' num2str(na) ', nb=' num2str(nb)]);
%         [~,fit]=compare(z2,th);
%         [num,den] = eqtflength(num1,conv(den1,[1 -1]));
%         [A,B,C,D] = tf2ss(num,den);
%         if th.Report.Fit.FitPercent>max
%             AA=A;
%             BB=B;
%             CC=C;
%             DD=D;
%             max=th.Report.Fit.FitPercent;
%         end
%         fit_arr(end+1)=fit;
%         j=j+2;
%         nb=nb+1;
%     end
%     i=i+1;
% end

na=6;
nk=1;
nb=4;

nc=na;
nn = [na nb nc nk];
th = armax(z,nn); % th is a structure in identification toolbox format
[den1,num1] = polydata(th);
yfsim = filter(num1,den1,utrend); % Equivalent to idsim(u,th);
zplane(num1,den1);
[~,fit]=compare(z2,th);
[num,den] = eqtflength(num1,conv(den1,[1 -1]));
[A,B,C,D] = tf2ss(num,den);
if th.Report.Fit.FitPercent>max
    AA=A;
    BB=B;
    CC=C;
    DD=D;
    max=th.Report.Fit.FitPercent;
end
fit_arr(end+1)=fit;
j=j+2;
nb=nb+1;

i=i+1;

yy=dlsim(AA,BB,CC,DD,utrend);
figure(7)
plot(yy)
hold on
plot(-ys)
hold off
title('Model Comparison')
legend('Model', 'observed');

save('statespace.mat','AA','BB','CC','DD')