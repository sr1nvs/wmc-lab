clc 
clear all
close all

fc = 700; 
hte = 10:10:100; hre = 1.5;
d = [5 10 20];

alpha_medium = (1.1 * log10(fc) - 0.7) * hre - (1.56 * log10(fc) - 0.8);
A = 69.55 + 29.19 * log10(fc) - 13.82 .* log10(hte) - alpha_medium;
B = 44.9 - 6.55 * log10(hte);

L50u_d1 = A + B .* log(d(1));
L50u_d2 = A + B .* log(d(2));
L50u_d3 = A + B .* log(d(3));

figure (1);
plot (hte, L50u_d1, 'LineWidth', 2); hold on;
plot (hte, L50u_d2, 'LineWidth', 2);
plot (hte, L50u_d3, 'LineWidth', 2); 
title ('hte vs Path Loss (Urban - Medium)'); xlabel ('Transmit Antenna Height (m)'); ylabel ('Path Loss (dB)');
hold off; legend ('d1 = 5km', 'd2 = 10km', 'd3 = 20km');