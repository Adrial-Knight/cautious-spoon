%% Cleanning
clear; close all; clc;
addpath("PQRST_Detection");
addpath("Analyse");

%% Datas
ecg_name = "AF";      % you can use space instead of underscore

load("../data/ecg_"+strrep(ecg_name, " ", "_")+".mat");
if max(ecg(1:5*Fs)) < -min(ecg(1:5*Fs))         % ecg polarity
    ecg = -ecg;
end

%% Parameters
N = floor(0.085*Fs);               % around QRS complex width, a normal QRS time interval is between 0.07 sec and 0.1 sec
window = 60;                          % to study the hearth mean during a windowed time in sec
time_unit = "sec";                 % axis time in "min" or in "sec"

%% Detection
[Atrial_res, t] = Atrial_test(ecg, N, window, Fs, time_unit);

%% Display

Atrial_positive = 1*(Atrial_res == 1);
Atrial_positive( Atrial_positive == 0) = NaN;
Atrial_negative = 1*(Atrial_res == 1);
Atrial_negative( Atrial_negative == 1) = NaN;

stem(t, Atrial_positive, "sr");
hold on;
plot(t, Atrial_negative, "sg");
legend("Atrial positive", "Atrial negative");
ylim([0, 1.2]);
ylabel("Atrial test");
xlabel("time ("+time_unit+")");
title("Atrial test on "+ecg_name+ " ecg");