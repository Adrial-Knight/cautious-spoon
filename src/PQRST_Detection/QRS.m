function pos = QRS(ecg, Fs, N)
%% Q, R and S waves detection
    % Pan and Tompkins algorithm
    ecg_low = lpf(ecg);
    ecg_band = hpf(ecg_low);
    ecg_deriv = differential(ecg_band, Fs);
    ecg_square = abs(ecg_deriv).^2;
    s_MVI = mwi(ecg_square, N);

    % Detection of maxima
    delay_R = 5 + 16 + 1 + floor((N)/2) + 1;                                                                   % offset due to filters
    threshold = mean(s_MVI) + sqrt(var(s_MVI));
    index = [s_MVI(delay_R:length(ecg)-delay_R) > threshold, zeros(1, 2*delay_R-1)];          % index to examine
    pos = zeros(5, length(ecg));                                            % P, Q, R, S, T positions
    
    for i = N:length(ecg)
        if (index(i))
            i_end = i;
            while (index(i_end))
                i_end = i_end + 1;
            end
            [R_value, R_local] = max(ecg(1, i: i_end));
            pos(3, i+R_local-1) = R_value;                        % R point
            [P_value, P_local] = min(ecg(1, i+R_local-N: i+R_local-1));
            pos(2, i+R_local-N+P_local-1) = P_value;    % Q point
            [S_value, S_local] = min(ecg(1, i+R_local+1: i+R_local+N));
            pos(4, i+R_local+S_local) = S_value;            % S point
            
            index(i: i_end) = zeros(1, i_end-i+1);
        end
    end
end