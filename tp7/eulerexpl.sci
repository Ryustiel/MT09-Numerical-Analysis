function [Z] = eulerexpl(a, t0, T, N, f)
    h = T/N
    p = size(a,'r')
    Z = zeros(p, N+1)
    Z(:,1) = a
    for n=1:N
        Z(:,n+1)=Z(:,n)+h*f(t0+n*h,Z(:,n))
    end
endfunction
