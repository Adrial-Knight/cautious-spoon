function [s_MVI] = mwi(ecg_square, N)
% N is around the QRS complex width
    s_MVI = zeros(1, length(ecg_square));
    for n=1:length(ecg_square)
        for i=0:N-1
            if (n-i > 0)
                s_MVI(n) = s_MVI(n) + ecg_square(n-i);
            end
        end
    end
    s_MVI = 1/N*s_MVI;
end
