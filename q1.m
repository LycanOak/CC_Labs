num = [1 -1];
dem = [1 0.2 1 0];

sys = tf(num,dem);

figure(1);
pzmap(sys);

figure(2);
rlocus(sys);



