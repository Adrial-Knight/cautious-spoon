function y = hpf(x)
    C = [
        -1, zeros(1,15), 32, -32, zeros(1, 14), 1;
        1, -1, zeros(1, 31)
    ];
    y = filter(C(1,:),C(2,:), x);
end