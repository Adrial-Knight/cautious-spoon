function [bpm, t] = heart_bpm(ecg, N, window, overlap, Fs, time_unit)
%heart_bpm compute the heart bpm of a given ecg
%   N : around QRS complex width, a normal QRS time interval is between 0.07 sec and 0.1 sec
%   window : study the hearth mean during a certain number of RR interval
%   overlap : must be less than window - 1
%   Fs : sampling frequency of the ecg studied
%   time_unit : to choose between a "min" or a "sec" time_axis

    L = RR_length(ecg, QRS(ecg, Fs, N));
    delay = L(1);
    L = L(2:length(L));             % the first one is not necessarily a complete RR interval
    
    %% Security
    if (window > length(L)/2)
        bpm = 60/(mean(L)/Fs);
        t = sum(L) + delay;
    else
        if (window - 1<= overlap)
            overlap = 0;
        end
        if ~(strcmp(time_unit, "min") || strcmp(time_unit, "sec"))
            time_unit = "min";
        end
        
        %% Compute Heart rate 
        bpm = zeros(1, floor((length(L)-window)/(window - overlap)));
        t = zeros(1, length(bpm));
        t(1) = delay;

        for i = 1:length(bpm)
            bpm(i)  = 60/(mean(L(1+(i-1)*(window - overlap) : i*(window - overlap)))/Fs);
            if i > 1
                t(i) = t(i - 1) + sum(L(1+(i-1)*(window - overlap) : i*(window - overlap)));
            end
        end
        t = t/(Fs*(1 + 59*strcmp(time_unit, "min")));       % convertion in time unit
    end
end