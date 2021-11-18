function y = differentiator(x)
    C = [ 
        1 0 0 0 0 0 -1;
        1 0 0 0 0 0 0
    ];
    y = filter(C(1,:), C(2,:), x);
end