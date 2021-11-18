%% Cleanning
clear; close all; clc;
addpath("PQRST_Detection");

%% Datas
ecg_name = "AF";      % you can use space instead of underscore

load("../data/ecg_"+strrep(ecg_name, " ", "_")+".mat");
if max(ecg(1:5*Fs)) < -min(ecg(1:5*Fs))         % ecg polarity
    ecg = -ecg;
end

%% Parameters
N = floor(0.085*Fs);       % around QRS complex width, a normal QRS time interval is between 0.07 sec and 0.1 sec
N_Fs = 15;                          % number of periode to display

%% Compute
pos = QRS(ecg, Fs, N);
RR_lengths = RR_length(ecg, pos);
pos = PT(ecg, RR_lengths, pos);                 % P Q R S T positions

%% Display
pos( pos == 0 ) = NaN;
plot(ecg(1:N_Fs*Fs)/max(abs(ecg)));
colors = ["c", "g", "r", "k", "m"];
for i= 1:5
    hold on;
    plot(pos(i,1:N_Fs*Fs)/max(abs(ecg)), strcat("s",colors(i)), "MarkerSize", 12, "MarkerEdgeColor", colors(i));
end
xlabel("Time (ms)");
ylabel("Electrical potential (normalized)");
title(ecg_name + " ecg", "interpreter", "none");
legend("ecg", "P points" , "Q points", "R points", "S points", "T point");
grid;