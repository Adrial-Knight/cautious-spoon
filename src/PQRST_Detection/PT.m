function PQRSTpos = PT(ecg, RR_lengths, QRSpos)
    %% P and T wave detection
    ecg_differentiator = differentiator(ecg);
    ecg_P_T = lpf_2(ecg_differentiator);
    delay_PT = 4;
    startI = ecg_P_T(1+delay_PT: 1 + RR_lengths(1));
    thres = .1*sqrt(var(startI));
    zeros_pos = (abs(startI) < thres);
    deriv = [0 diff(startI)].*zeros_pos;
    [~, pPos] = min(deriv);
    if ( pPos-delay_PT+1 > 0)
        QRSpos(1, pPos-delay_PT+1) = ecg(pPos-delay_PT+1);
    end

    RR_begin = RR_lengths(1);
    for i = 2:length(RR_lengths)
        RR_interval = ecg_P_T(RR_begin+delay_PT: RR_begin + RR_lengths(i));
        thres = .1*sqrt(var(RR_interval));
        zeros_pos = (abs(RR_interval) < thres);
        deriv = [0 diff(RR_interval)].*zeros_pos;
        cursor = floor(.7*length(RR_interval));
        firstPart = deriv(1:cursor);
        [~, Tpos] = min(firstPart);
        lastPart = deriv(cursor+1:length(RR_interval));
        [~, Ppos] = min(lastPart);
        QRSpos(1, RR_begin + Ppos+cursor+1 - delay_PT) = ecg(RR_begin + Ppos+cursor+1-delay_PT); % group delay: 4
        QRSpos(5, RR_begin + Tpos - delay_PT) = ecg(RR_begin + Tpos-delay_PT); % group delay: 4

        RR_begin = RR_begin + RR_lengths(i);
    end
    PQRSTpos = QRSpos;
end