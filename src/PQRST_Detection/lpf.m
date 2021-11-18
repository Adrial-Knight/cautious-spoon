function [output] = lpf(signal)
    lp = [
        1 0 0 0 0 0 -2 0 0 0 0 0 1;
        1 -2 1 0 0 0 0 0 0 0 0 0 0
    ];
    output = filter(lp(1, :), lp(2, :), signal);

end