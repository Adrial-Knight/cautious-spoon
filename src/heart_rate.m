%% Cleanning
clear; close all; clc;
addpath("PQRST_Detection"); addpath("Analyse");

%% Datas
ecg_name = "normal 1";      % you can use space instead of underscore

load("../data/ecg_"+strrep(ecg_name, " ", "_")+".mat");
if max(ecg(1:5*Fs)) < -min(ecg(1:5*Fs))         % ecg polarity
    ecg = -ecg;
end

%% Parameters
N = floor(0.085*Fs);               % around QRS complex width, a normal QRS time interval is between 0.07 sec and 0.1 sec
window = 30;                          % to study the hearth mean during a certain number of RR interval
overlap = 20;                           % less than window - 1
time_unit = "min";               % axis time in "min" or in "sec"

%% Compute Heart rate
[bpm, t] = heart_bpm(ecg, N, window, overlap, Fs, time_unit);

%% Display
plot(t, bpm, "s");
xlabel("ecg time ("+time_unit+")");
ylabel("heart rate (bpm)");
title(ecg_name + " Heart rate");
grid;