function [Atrial, t] = Atrial_test(ecg, N, window, Fs, time_unit)
%Atrial_test detects atrial fibrilation of a given ecg 
%   This function returns a boolean table. 1: atrial is detected in the corresponding time interval
%   N : around QRS complex width, a normal QRS time interval is between 0.07 sec and 0.1 sec
%   window : time interval in seconds
%   Fs : sampling frequency of the ecg studied
%   time_unit : to choose between a "min" or a "sec" time_axis

    Atrial = zeros(1, floor(length(ecg)/(Fs*window)));
    t = zeros(1, length(Atrial));
    
    for i = 1:length(Atrial)
        ecg_studied = ecg(window*Fs*(i-1)+1: window*Fs*i);
        L = RR_length(ecg_studied, QRS(ecg_studied, Fs, N));
        a_cor = xcorr(L, 'unbiased');

        % Trunk the extrem auto-corr values, with a huge variation
        trunk = floor(1/6*length(a_cor))+1:floor(5/6*length(a_cor));
        Acor_trunk = a_cor(trunk);
        Acor_trunk = a_cor(trunk) - mean(Acor_trunk);

        % Treshold to detect white noise pic
        threshold = 0.95*var(L);
        Atrial(i) = (sum(Acor_trunk > threshold) == 1);
        
        % Time correspondance
        if i > 1
            t(i) = t(i-1) + window;
        end
    end
    t = t/(1 + 59*strcmp(time_unit, "min"));       % convertion in time unit
end