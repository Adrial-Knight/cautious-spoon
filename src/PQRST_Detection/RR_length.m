function L= RR_length(ecg, QRSpos)
%% Determines the lengths of RR intervals in the ECG
    % RR_intervals length
    R_pos = QRSpos(3,:) > 0;
    L = zeros(1, sum(R_pos));
    RR_length = 0; j = 1;
    for i = 1:length(ecg)
        if R_pos(i)
            L(j) = RR_length;
            RR_length = 0;
            j = j+1;
        else
            RR_length = RR_length+1;
        end
    end
end

