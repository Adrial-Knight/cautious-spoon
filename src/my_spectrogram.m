%% Cleanning
clear; close all; clc;
addpath("STFT_functions");

%% Parameters
signal_name = "normal_1";
Nfft = 2^10;
overlap = 0.75 * Nfft;
window = hanning(Nfft);

%% Display our spectrogram result
load("../data/ecg_"+signal_name+".mat");

[X, f, t] = stft(ecg, window, overlap, Nfft, Fs);
imagesc(t, f(1:length(f)/2+1), 20*log(abs(X(length(X)/2+1:length(X), :))));
xlabel("time (s)");
ylabel("frequency (Hz)");
colorbar;
title(signal_name+" ecg with our spectrogram", 'Interpreter', 'none');

%% Display MatLab spectrogram result
figure;
[X, f, t] = spectrogram(ecg, window, overlap, Nfft, Fs);
imagesc(t, f, 20*log(abs(X)));
xlabel("time (s)");
ylabel("frequency (Hz)");
colorbar;
title(signal_name+" ecg with MatLab spectrogram", 'Interpreter', 'none');