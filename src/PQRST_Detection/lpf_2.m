function y = lpf_2(x)
    B = [ 1 0 0 0 0 0 0 0 -1 ];
    A = [ 1 -1 0 0 0 0 0 0 0 ];
    y = filter(B, A, x);
end