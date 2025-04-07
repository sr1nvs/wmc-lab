clc; clear all; close all;

SNR_dB = 0:5:60;
SNR = 10.^(SNR_dB/10); % Linear SNR

% number of rx antennas
L_values = [1, 2, 4, 8];

BER = zeros(length(L_values), length(SNR_dB));

for l_idx = 1:length(L_values)
    L = L_values(l_idx);
    
    for snr_idx = 1:length(SNR)
        snr = SNR(snr_idx);
        
        lambda = sqrt(snr/(2 + snr));
        
        ber = 0;
        
        % summation term
        for k = 0:L-1
            binomial_coeff = nchoosek(L+k-1, k);
            term = binomial_coeff * ((1 + lambda)/2)^k;
            ber = ber + term;
        end
        
        % final calculation
        BER(l_idx, snr_idx) = ((1 - lambda)/2)^L * ber;
    end
end

figure;
semilogy(SNR_dB, BER(1,:), 'b-o', 'LineWidth', 2, 'MarkerSize', 8); hold on;
semilogy(SNR_dB, BER(2,:), 'r-s', 'LineWidth', 2, 'MarkerSize', 8);
semilogy(SNR_dB, BER(3,:), 'g-d', 'LineWidth', 2, 'MarkerSize', 8);
semilogy(SNR_dB, BER(4,:), 'm-^', 'LineWidth', 2, 'MarkerSize', 8);
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BER vs SNR for MRC with Multiple Receive Antennas');
legend('L=1', 'L=2', 'L=4', 'L=8', 'Location', 'SouthWest');
set(gca, 'FontSize', 12);
axis([0 60 1e-12 1]);

