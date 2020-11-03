load('iodata1.mat')
max=0

Ts = mean(diff(ts)); % Intervalo de amostragem (s)
utrend=us;
ytrend=ys;
figure(1)
plot(utrend)
figure(2)
plot(ys)
af = 0.8;
Afilt = [1 -af];
Bfilt = (1-af)*[1 -1];
% Filtragem seguida de eliminação de tendências
% Filtering and detrending
yf = filter(Bfilt,Afilt,ytrend);
% u = detrend(utrend);
% figure(1)
% plot(u)
% fit=[0 0 0 0 0 0 0 0 0 0]
z = [yf utrend];
% u2=square(2*pi*0.02*ts) 
% z2=[
fit=[0];
j=1;
for i=2:6
    na=i;
    nk=1;
    nb=1;
    while nb<na
        
%na = 3; % AR part
%nb = 2; % X part
%nc = na; % MA part
%nk = 1; % Atraso puro – pure delay
        %nk=1
        nc=na;
        nn = [na nb nc nk];
        th = armax(z,nn) % th is a structure in identification toolbox format
        nb=nb+1;
        [den1,num1] = polydata(th);
        yfsim = filter(num1,den1,utrend); % Equivalent to idsim(u,th);
        figure(j)
        plot(yfsim)
        title(['na =' num2str(na) ', nb=' num2str(nb)])
        [num,den] = eqtflength(num1,conv(den1,[1 -1]));
        [A,B,C,D] = tf2ss(num,den);
        if th.Report.Fit.FitPercent>max
            AA=A;
            BB=B;
            CC=C;
            DD=D;
            max=max;
        end
        fit(end+1)=th.Report.Fit.FitPercent;
        j=j+1;
    end
    i=i+1;
end

% yy=dlsim(AA,BB,CC,DD,utrend);
% figure(7)
% plot(yy)