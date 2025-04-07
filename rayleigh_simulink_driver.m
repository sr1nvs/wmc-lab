EbN0_ar = 0:2:20; % array of snr values

BER_awgn = zeros (2, length(EbN0_ar));
BER_rayl = zeros (2, length(EbN0_ar));
BER_ricn = zeros (2, length(EbN0_ar));

for i = 1:length(EbN0_ar)
    EbN0 = EbN0_ar(i); 
    % run sim
    out = sim('WMC_Exp6a_1519');

    BER_awgn(1, i) = EbN0;
    BER_awgn(2, i) = out.simout.Data(:, 1);
end

for i = 1:length(EbN0_ar)
    EbN0 = EbN0_ar(i); 
    % run sim
    out = sim('WMC_Exp6b_1519');
    
    BER_rayl(1, i) = EbN0;
    BER_rayl(2, i) = out.simout.Data(:, 1);
end

for i = 1:length(EbN0_ar)
    EbN0 = EbN0_ar(i); 
    % run sim
    out = sim('WMC_Exp6c_1519');
    
    BER_ricn(1, i) = EbN0;
    BER_ricn(2, i) = out.simout.Data(:, 1);
end

close all

BER_awgn = BER_awgn';
BER_rayl = BER_rayl';
BER_ricn = BER_ricn';

figure;
plot (BER_awgn(:, 1), BER_awgn (:, 2), 'LineWidth', 2); hold on;
plot (BER_rayl(:, 1), BER_rayl (:, 2), 'LineWidth', 2);
plot  (BER_ricn(:, 1), BER_ricn (:, 2), 'LineWidth', 2); hold off;
title ('BER vs SNR'); xlabel ('Eb/N0'); ylabel ('BER');
legend ('AWGN', 'Rayleigh', 'Rician');