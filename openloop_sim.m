clear all;
load('barrassmodel.mat');

TS = [0.01 0.1 0.15 0.2 0.25 0.3 0.35];
tfinal = 200;
for Ts = TS
    sim('simbarra_step');
    figure();
    plot(t,-y);
    hold on
    plot(ts,-ys);
    legend('y(t)','ys(ts)');
    xlabel('time [s]');
    ylabel('y [rad]');
    title(['Angular Position of the tip of the bar for Ts = ', num2str(Ts), 's']);
    hold off
    
    figure();
    %compute the derivative
    ytrend = ys;
    af = 0.8;
    Afilt = [1 -af];
    Bfilt = (1-af)*[1 -1];
    yf = filter(Bfilt,Afilt,ytrend);
    plot(ts,-yf);
    hold on
    plot(ts, us);
    xlabel('time [s]');
    title(['Motor Behavior for Ts = ', num2str(Ts), 's'] );
end