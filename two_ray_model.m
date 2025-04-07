clc
clear all
close all

f = 900e6; w = 3e8/f;
Pt = 10;
Gt = 5; Gr = 3; 
ht = 40; hr = 3;
d = 100:100:2000;

Pr = ((Pt * Gt * Gr) .* (ht.^2) .* (hr.^2))./(d.^4);
PL = 40*log10(d) - (10*log10(Gt) + 10*log10(Gr) + 20*log10(ht) + 20*log10(hr));

figure(1);
plot(d, Pr, 'LineWidth', 2); title ('Distance vs Received Power');
xlabel('Distance(m)'); ylabel ('Received Power (W)');

figure(2);
plot(d, PL, 'LineWidth', 2); title ('Distance vs Path Loss');
xlabel('Distance(m)'); ylabel ('Path Loss (dB)');