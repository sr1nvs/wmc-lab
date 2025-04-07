clc
clear all
close all

f1 = 700; f2 = 900;
hte = 30; hre = 1.5;
d = 1:2:20;

alpha_medium1 = (1.1 * log10(f1) - 0.7) * hre - (1.56 * log10(f1) - 0.8);
alpha_medium2 = (1.1 * log10(f2) - 0.7) * hre - (1.56 * log10(f2) - 0.8);

alpha_large = 3.2 * (log10(1.54 * hre).^2) - 4.97;

A1 = 69.55 + 29.19 * log10(f1) - 13.82 * log10(hte) - alpha_medium1;
A2 = 69.55 + 29.19 * log10(f2) - 13.82 * log10(hte) - alpha_medium2;
A3 = 69.55 + 29.19 * log10(f1) - 13.82 * log10(hte) - alpha_large;
A4 = 69.55 + 29.19 * log10(f2) - 13.82 * log10(hte) - alpha_large;

B = 44.9 - 6.55 * log10(hte);

L50uf1_m = A1 + B * log10 (d);
L50uf2_m = A2 + B * log10 (d); % Urban - Medium

L50uf1_l = A3 + B * log10 (d);
L50uf2_l = A4 + B * log10 (d); % Urban - Large

L50sf1_m = L50uf1_m - (2 * (log10(f1/28).^2) + 5.4);
L50sf2_m = L50uf2_m - (2 * (log10(f2/28).^2) + 5.4); % Suburban

L50rf1_m = L50uf1_m - (4.78 * (log10(f1).^2) + (18.33 * log10 (f1)) + 40.98);
L50rf2_m = L50uf2_m - (4.78 * (log10(f2).^2) + (18.33 * log10 (f2)) + 40.98);

figure (1);
plot (d, L50uf1_m, 'LineWidth', 2); 
hold on;
plot (d, L50uf2_m, 'LineWidth', 2); 
title ('Distance vs Path Loss (Urban - Medium)'); xlabel ('Distance (km)'); ylabel ('Path Loss (dB)');
hold off; legend ('fc = 700MHz', 'fc = 900MHz');

figure (2);
plot (d, L50uf1_l, 'LineWidth', 2); 
hold on;
plot (d, L50uf2_l, 'LineWidth', 2); 
title ('Distance vs Path Loss (Urban - Large)'); xlabel ('Distance (km)'); ylabel ('Path Loss (dB)');
hold off; legend ('fc = 700MHz', 'fc = 900MHz');

figure (3);
plot (d, L50sf1_m, 'LineWidth', 2); 
hold on;
plot (d, L50sf2_m, 'LineWidth', 2); 
title ('Distance vs Path Loss (Suburban)'); xlabel ('Distance (km)'); ylabel ('Path Loss (dB)');
hold off; legend ('fc = 700MHz', 'fc = 900MHz');

figure (4);
plot (d, L50rf1_m, 'LineWidth', 2); 
hold on;
plot (d, L50rf2_m, 'LineWidth', 2); 
title ('Distance vs Path Loss (Rural)'); xlabel ('Distance (km)'); ylabel ('Path Loss (dB)');
hold off; legend ('fc = 700MHz', 'fc = 900MHz');

