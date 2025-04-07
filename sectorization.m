%%

clc
clear all
close all

n = 3; % Path loss exp
N = [5; 7; 19];

SINR_NO_SECTORS = ((3.*N).^(n/2)) / 6;
SINR_120_SECTORS = ((3.*N).^(n/2)) / 2;
SINR_60_SECTORS = ((3.*N).^(n/2)) / 1;

table(N, SINR_NO_SECTORS, SINR_60_SECTORS, SINR_120_SECTORS)

%%


D = 0.5:0.1:2;
n = [2 4];
R = 5;

Q = D./R;
SIR_2 = ((Q).^ n(1)) / 6; 
SIR_4 = ((Q) .^ n(2)) / 6;

figure;
plot(D, SIR_2, 'b', 'LineWidth', 2); hold on;
plot(D, SIR_4, 'r', 'LineWidth', 2); hold off;
title('SIR vs D'); xlabel('Distance(km)'); ylabel('SIR');
legend('n = 2', 'n = 4');