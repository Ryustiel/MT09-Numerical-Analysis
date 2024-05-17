function Z = RK4(a, t0, T, N, f)
    h = T/N
    p = size(a)(1)
    Z = zeros(p, N+1)
    Z(:,1) = a
    for n=1:N
        k0 = f(t0+n*h, Z(:,n))
        k1 = f(t0+n*h + 0.5*h, Z(:,n) + 0.5*h*k0)
        k2 = f(t0+n*h + 0.5*h, Z(:,n) + 0.5*h*k1)
        k3 = f(t0+n*h + h, Z(:,n) + h*k2)
        Z(:,n+1) = Z(:,n) + (h/6)*(k0+2*k1+2*k2+k3)
    end
endfunction
