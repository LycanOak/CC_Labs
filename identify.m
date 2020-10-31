load('iodata1.mat')


Ts = mean(diff(ts)); % Intervalo de amostragem (s)
utrend=us;
ytrend=ys;
figure(1)
plot(ys)
af = 0.5;
Afilt = [1 -af];
Bfilt = (1-af)*[1 -1];
% Filtragem seguida de eliminação de tendências
% Filtering and detrending
yf = filter(Bfilt,Afilt,ytrend);
figure(2)
plot(yf)
% u = detrend(utrend);
% figure(1)
% plot(u)
% fit=[0 0 0 0 0 0 0 0 0 0]
% z = [yf u];
% % z2=[
% fit=[0]
% for i=1:8
%     na=i
%     nk=1
%     nb=1
%     while nb<=na
%         
% %na = 3; % AR part
% %nb = 2; % X part
% %nc = na; % MA part
% %nk = 1; % Atraso puro – pure delay
%         %nk=1
%         nc=na
%         nn = [na nb nc nk];
%         th = armax(z,nn) % th is a structure in identification toolbox format
%         nb=nb+1
%         [den1,num1] = polydata(th);
%         yfsim = filter(num1,den1,u); % Equivalent to idsim(u,th);
%         figure(2)
%         plot(yfsim)
%         [num,den] = eqtflength(num1,conv(den1,[1 -1]));
%         
%         fit(end+1)=th.Report.Fit.FitPercent
%     end
%     i=i+1
% end