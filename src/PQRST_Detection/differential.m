function output = differential(input, Fs)
    C = [
        1, 2, 0, -2, -1;
        8/Fs, zeros(1, 4)
    ];
    output = filter(C(1,:),C(2,:), input);
end

