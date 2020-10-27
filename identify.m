load('iodata1.mat')

% yss=detrend(ys)
% uss=detrend(us)
% plot(us)
% figure()
% plot(ys)

Ts = mean(diff(ts)); % Intervalo de amostragem (s)
utrend=us;
ytrend=ys;

af = 0.8;
Afilt = [1 -af];
Bfilt = (1-af)*[1 -1];
% Filtragem seguida de eliminação de tendências
% Filtering and detrending
yf = filter(Bfilt,Afilt,ytrend);

u = detrend(utrend);

plot(yf)
figure()
plot(u)

% z = [y u];
% na = 3; % AR part
% nb = 2; % X part
% nc = na; % MA part
% nk = 1; % Atraso puro – pure delay
% nn = [na nb nc nk];
% th = armax(z,nn) % th is a structure in identification toolbox format
% 
% [den1,num1] = polydata(th);
% 
% yfsim = filter(num1,den1,u); % Equivalent to idsim(u,th);
% 
% [num,den] = eqtflength(num1,conv(den1,[1 -1]));

