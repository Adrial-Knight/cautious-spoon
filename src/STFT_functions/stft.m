function [X, f, t] = stft(x,w,d,N,Fs)
%This function computes the stft for m = [0, d, 2d, 3d...]
% This function outputs are:
% -> X, which is  a matrix of n_fft lines and M columns
%    M is the number of elements of m
%    X(i,j) is the value of the spectrogram for time t(i) and frequency f(j)
% -> f, is a column vector of the frequencies (in Hz)
% -> t, is a row vector containing the times of the beginning of the windows

L = length(x);
M = floor(L/d)-mod(L,2);
f = 0:Fs/(N-1):Fs;
t = zeros(1, M+1);

X = zeros(N, M+1);

    for col = 1:M
        for row = 1:N
            X(row, col) = x((col-1)*d + row);
        end
        X(:, col) = X(:, col).*w;
    end
    row = 1;
    for last = M*d:L
        X(row, M+1) = x(last);
        row = row + 1;
    end
    
    for col = 1:M+1
    X(:,col) = fftshift(fft(X(:, col), N));
    t(col) = (col-1)*d/Fs;
    end
    sizeX = size(X);
    X = X(:, floor(sizeX(2)/2):sizeX(2));
end

