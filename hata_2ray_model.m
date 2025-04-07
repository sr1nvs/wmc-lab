clc 
clear all
close all

fc = 900; 
hte = 30; hre = 1.5;
d = 1:1:10;

alpha_medium = (1.1 * log10(fc) - 0.7) * hre - (1.56 * log10(fc) - 0.8);
A = 69.55 + 29.19 * log10(fc) - 13.82 * log10(hte) - alpha_medium;
B = 44.9 - 6.55 * log10(hte);

L50u_hata = A + B * log10 (d);
PL_2ray = 40 * log10 (d * 1e3) - ((10 * log10 (1)) - (10 * log10 (1)) + (20 * log10 (hte)) + (20 * log10 (hre)));

figure (1);
plot (d, L50u_hata, 'LineWidth', 2); 
hold on;
plot (d, PL_2ray, 'LineWidth', 2); 
title ('Distance vs Path Loss (Urban - Medium)'); xlabel ('Distance (km)'); ylabel ('Path Loss (dB)');
hold off; legend ('Hata Model', 'Two-Ray Model');