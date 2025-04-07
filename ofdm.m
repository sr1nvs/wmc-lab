clc

% Step 1: Create a simple OFDM system
bps = 4;        % Bits per symbol
M = 2^bps;      % 16QAM
nFFT = 128;     % Number of FFT bins
txsymbols = randi([0 M-1],nFFT,1);

txgrid = qammod(txsymbols,M,UnitAveragePower=true);
txout = ifft(txgrid,nFFT);
stem(1:nFFT,real(txout))
title ('Real part of OFDM Signal')
xlabel('Sample Index')
ylabel('Amplitude')
grid on


rxin = awgn(txout,40);
rxgrid = fft(rxin,nFFT);
rxsymbols = qamdemod(rxgrid,M,UnitAveragePower=true);
if isequal(txsymbols,rxsymbols)
    disp("Recovered symbols match the transmitted symbols.")
else
    disp("Recovered symbols do not match transmitted symbols.")
end

% Step 2: Impulse Response of Multipath Channel
u1 = 1:8;
h = [0.4 1 0.4];
figure
subplot(2,1,1)
stem(u1, 'LineWidth', 2);
axis([0 10 0 10])
xlabel('Sample Index')
ylabel('Amplitude')
title("Input signal")
grid on
subplot(2,1,2)
stem(h,'^', 'LineWidth', 2);
axis([0 10 0 2])
xlabel('Tap Index')
ylabel('Amplitude')
title("Channel Impulse Response")
grid on


% Step 3: Addition of Cyclic Prefix
L = length(h);      % Length of channel
N = length(u1);     % Length of input signal
ucp = u1(N-L+1:N);  % Use last samples of input signal as the CP
u2 = [ucp u1];      % Prepend the CP to the input signal
yl2 = conv(u2,h);   % Convolution of input+CP and channel
yc1 = yl2(L+1:end); % Remove CP to compare signals

figure;
stem(yl2,"x", 'LineWidth', 2)
hold on;
stem(yc1,"o", 'LineWidth', 2)
title("Convolution Results with Cyclic Prefix")
legend ("Linear", "Circular", "Location", "northwest")

bps = 4;    % Number of bits per symbol
M = 2^bps;  % Modulation order
nFFT = 128; % Number of FFT bins
nCP = 8;    % CP length

txsymbols = randi([0 M-1],nFFT,1);
txgrid = qammod(txsymbols,M,UnitAveragePower=true);
txout = ifft(txgrid,nFFT);

txout = txout(:);
txcp = txout(nFFT-nCP+1:nFFT);
txout = [txcp; txout];
hchan = [0.4 1 0.4].';
rxin = awgn(txout,40);      % Add noise
rxin = conv(rxin,hchan);    % Add frequency dependency
channelDelay = dsp.Delay(1);% Could use fractional delay
rxin = channelDelay(rxin);  % Add delay

% Add random offset
offset = randi(nCP) - 1;    % random offset less than length of CP
rxsync = rxin(nCP+1+channelDelay.Length-offset:end);
rxgrid = fft(rxsync(1:nFFT),nFFT);

useEqualizer = true;
if useEqualizer
    hfchan = fft(hchan, nFFT);
    offsetf = exp(-1i * 2*pi*offset * (0:nFFT-1).'/nFFT);
    rxgrideq = rxgrid ./ (hfchan .* offsetf);
else % Without equalization errors occur
    rxgrideq = rxgrid;
end
rxsymbols = qamdemod(rxgrideq,M,UnitAveragePower=true);
if max(txsymbols - rxsymbols) < 1e-8
    disp("Receiver output matches transmitter input.");
else
    disp("Received symbols do not match transmitted symbols.")
end

