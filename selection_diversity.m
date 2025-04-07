clc; clear all; close all;

N = 1e6;
SNR_dB = 0:2:30;
SNR_lin = 10 .^ (SNR_dB./10);

BER_no_div = zeros (1, length(SNR_dB));
BER_sel_div = zeros (1, length(SNR_dB));

for i = 1:length(SNR_dB)
    bits = randi ([0 1], 1, N);
    
    s = 2*bits - 1; % bpsk modulation
    
    h1 = (randn(1, N) + 1j * randn (1, N)) / sqrt (2);
    h2 = (randn(1, N) + 1j * randn (1, N)) / sqrt (2);
    
    r_no_div = h1 .* s; % without diversity
    noise_no_div = (randn(1, N) + 1j * randn (1, N)) / sqrt (2 * SNR_lin(i));
    y_no_div = r_no_div + noise_no_div;
    y_eq_no_div = y_no_div ./ h1; % zero forcing equalization
    bits_rx_no_div = real (y_eq_no_div) > 0; % bpsk demodulation
    BER_no_div(i) = sum (bits ~= bits_rx_no_div) / N;
    
    r1 = h1 .* s; % with diversity - 2 branches
    r2 = h2 .* s;
    noise1 = (randn(1, N) + 1j * randn (1, N)) / sqrt (2 * SNR_lin(i));
    noise2 = (randn(1, N) + 1j * randn (1, N)) / sqrt (2 * SNR_lin(i));
    y1 = r1 + noise1; y2 = r2 + noise2;
    SNR1 = abs (h1.^2);
    SNR2 = abs (h2.^2);
    y_sel = y1;
    h_sel = h1; % select default
    y_sel (SNR2 > SNR1) = y2 (SNR2 > SNR1);
    h_sel (SNR2 > SNR1) = h2 (SNR2 > SNR1); % if snr2 greater, select y2 and h2
    y_eq_sel = y_sel ./ h_sel;
    bits_rx_sel_div = real (y_eq_sel) > 0;
    BER_sel_div(i) = sum (bits ~= bits_rx_sel_div) / N;
    
end

BER_theory_no_div = 0.5 * (1 - sqrt (SNR_lin ./ (1+SNR_lin)));
BER_theory_sel_div = 0.5 * (1 - sqrt (SNR_lin ./ (1+SNR_lin))).^2;

figure(1);
semilogy (SNR_dB, BER_theory_no_div, 'LineWidth', 2); hold on;
semilogy (SNR_dB, BER_theory_sel_div, 'LineWidth', 2); hold off;
title ('Performance Analysis of Selection Diversity');
xlabel ('SNR (dB)'); ylabel ('BER');
legend ('Theory - No Diversity', 'Theory - Selection Diversity');

figure(2);
semilogy (SNR_dB, BER_no_div, 'LineWidth', 2); hold on;
semilogy (SNR_dB, BER_sel_div, 'LineWidth', 2); hold off;
title ('Performance Analysis of Selection Diversity');
xlabel ('SNR (dB)'); ylabel ('BER');
legend ('Simulated - No Diversity', 'Simulated - Selection Diversity');
    
figure(3);
semilogy (SNR_dB, BER_theory_no_div, 'LineWidth', 2); hold on;
semilogy (SNR_dB, BER_theory_sel_div, 'LineWidth', 2);
semilogy (SNR_dB, BER_no_div, 'LineWidth', 2);
semilogy (SNR_dB, BER_sel_div, 'LineWidth', 2); hold off;
title ('Performance Analysis of Selection Diversity');
xlabel ('SNR (dB)'); ylabel ('BER');
legend ('Theory - No Diversity', 'Theory - Selection Diversity', ...
    'Simulated - No Diversity', 'Simulated - Selection Diversity');
    
    