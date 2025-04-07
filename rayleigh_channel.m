clc 
clear all 
close all 
 
N = 1e6; % Number of symbols 
EbN0_dB = 0:2:20; % SNR Range (dB) 
 
data = randi([0 1], 1, N); % Random binary data 
 
bpsk_symbols = 2*data - 1; % 0 -> -1, 1 -> 1 
 
ber_bpsk = zeros (1, length(EbN0_dB)); 
 
for i = 1:length(EbN0_dB) 
     
    EbN0 = 10 ^ (EbN0_dB(i)/10); 
    noise_variance = 1 / (2 * EbN0); 
     
    rayleigh_fading = (randn(1, N) + 1i * randn(1, N)) / sqrt (2); 
     
    received_signal = (rayleigh_fading .* bpsk_symbols) + sqrt (noise_variance) * (randn (1, N) + 1i * randn (1, N)); % Rayleigh 

    equalized_signal = real (received_signal ./ rayleigh_fading); % Tx Real Signal only 
     
    detected_data = equalized_signal > 0; 
    ber_bpsk(i) = sum(detected_data ~= data) / N; 
     
end 
 
 
EbN0_linear = 10 .^ (EbN0_dB/10); 
ber_bpsk_theory = 0.5 .* (1 - sqrt(EbN0_linear ./ (EbN0_linear+1))); 
 
figure; 
semilogy(EbN0_dB, ber_bpsk, 'o-', 'LineWidth', 2); 
hold on; 
semilogy(EbN0_dB, ber_bpsk_theory, 'r-', 'LineWidth', 2); 
xlabel ('Eb/N0 (dB)'); ylabel ('Bit Error Rate (BER)'); 
title ('BER of BPSK over Rayleigh Fading Channel'); 
legend ('Simulated BPSK over Rayleigh', 'Theoretical BPSK over Rayleigh'); 
grid on; 

%%

clc 
clear all 
close all 
 
rng (43); 
 
N = 1e6; % Number of symbols 
EbN0_dB = 0:2:20; % SNR Range (dB) 
 
data = randi([0 1], 1, N); % Random binary data 
 
bpsk_symbols = 2*data - 1; % 0 -> -1, 1 -> 1 
 
ber_bpsk_awgn = zeros (1, length(EbN0_dB)); 
 
for i = 1:length(EbN0_dB) 
     
    EbN0 = 10 ^ (EbN0_dB(i)/10); 
    noise_variance = 1 / (2 * EbN0); 
        
    received_signal1 = bpsk_symbols + sqrt (noise_variance) * (randn (1, N) + 1i * randn (1, N)); % AWGN Only 
    equalized_signal1 = real (received_signal1); 
     
    detected_data1 = equalized_signal1 > 0; 
 
    ber_bpsk_awgn(i) = sum(detected_data1 ~= data) / N; 
     
end 
 
figure (1); 
semilogy(EbN0_dB, ber_bpsk_awgn, 'o-', 'LineWidth', 2); 
xlabel ('Eb/N0 (dB)'); ylabel ('Bit Error Rate (BER)'); 
title ('BER of BPSK over AWGN Channel'); 
grid on;