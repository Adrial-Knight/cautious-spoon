%% Cleanning
clear; close all; clc;

%% Parameters
name = ["normal_1", "VF"];              % 2 ecg names required
Nfft = 2^13;                                            % point number for FFT

%% Datas
ECG = [load("../data/ecg_"+name(1)+".mat"), load("../data/ecg_"+name(2)+".mat")];

%% Display
for i=1:length(ECG)
    subplot(2, 1, i);
    overlap = 3*ECG(i).Fs;
    window = hanning(4*ECG(i).Fs);

    [X, f, t] = spectrogram(ECG(i).ecg, window, overlap, Nfft, ECG(i).Fs);
    imagesc(t, f, 20*log(abs(X)));
    ylim([0, 1.8]);                 % correspond to normal hearth frequency
    xlabel("time (s)");
    ylabel("frequency (Hz)");
    colorbar;
    title(name(i)+ " spectrogram", 'Interpreter', 'none');
end