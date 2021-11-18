%% setup
close all;
clear;
clc;
addpath("../PQRST_Detection");

% Data
ecg_name = "AF";      % you can use space instead of underscore

load("../data/ecg_"+strrep(ecg_name, " ", "_")+".mat");
if max(ecg(1:5*Fs)) < -min(ecg(1:5*Fs))         % ecg polarity
    ecg = -ecg;
end

N = floor(0.085*Fs);       % around QRS complex width, a normal QRS time interval is between 0.07 sec and 0.1 sec

pos = QRS(ecg, Fs, N);
RRs = RR_length(ecg, pos);
RRs = RRs(2:length(RRs));

RR_diff = diff(RRs);
threshold = mean(RR_diff) + 4*sqrt(var(RR_diff));

plot(RR_diff);
yline(threshold);