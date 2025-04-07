clc
clear all
close all

f = 900e6; w = 3e8/f;
Pt = 10;
Gt = 5; Gr = 3;
L = 16; d = 100:100:2000;

Pr = (Pt * Gt * Gr * w.^2)./((16*pi.^2).*(d.^2).*L);
PL = 10*log10(Pt./Pr);

figure(1);
plot(d, Pr, 'LineWidth', 2); title ('Distance vs Received Power');
xlabel('Distance(m)'); ylabel ('Received Power (W)');

figure(2);
plot(d, PL, 'LineWidth', 2); title ('Distance vs Path Loss');
xlabel('Distance(m)'); ylabel('Path Loss (dB)');