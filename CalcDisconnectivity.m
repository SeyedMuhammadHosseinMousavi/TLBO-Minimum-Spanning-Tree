function q=CalcDisconnectivity(A)
    n=size(A,1);
    L=logical((eye(n)+A)^n);
    q=1-mean(L(:));
end