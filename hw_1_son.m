[y, Fs] = audioread('Kayıt.m4a');
if size(y, 2) > 1
    y = mean(y, 2); % Stereo ise mono yap
end

nf = 30;             % Frame süresi (ms)
n_over = 14;         % Overlap süresi (ms)
fr_samp = floor(Fs * nf * 1e-3);     % Frame uzunluğu
fr_over = floor(Fs * n_over * 1e-3); % Overlap uzunluğu
hop = fr_samp - fr_over;             % Frame atlama uzunluğu

win = hamming(fr_samp);
numSegments = floor((length(y) - fr_samp) / hop) + 1;

% energy and zero crossing
energies = zeros(1, numSegments);
zero_crossing = zeros(1, numSegments);

for i = 1:numSegments
    start_idx = (i-1)*hop + 1;
    end_idx = start_idx + fr_samp - 1;
    segment = y(start_idx:end_idx) .* win;
    % energy and zero crossing calc
    energies(i) = sum(segment.^2);
    zero_crossing(i) = sum(abs(diff(sign(segment)))) / 2;
end

%normalization and treshold
energies = energies / max(energies);
energy_threshold = 0.02;

reconstructed_signal = [];

for i = 1:numSegments
    if energies(i) > energy_threshold
        start_idx = (i-1)*hop + 1;
        end_idx = start_idx + fr_samp - 1;
        if end_idx <= length(y)
            reconstructed_signal = [reconstructed_signal; y(start_idx:end_idx)];
        end
    end
end

figure;
subplot(4,1,1);
plot(y);
title('Orijinal Ses');
subplot(4,1,2);
plot(reconstructed_signal);
title('Sessizlikler Temizlenmiş Ses');
subplot(4,1,3);
plot(energies);
title('Frame Enerjisi');
subplot(4,1,4);
plot(zero_crossing);
title('Zero Crossing Rate');

sound(reconstructed_signal, Fs);