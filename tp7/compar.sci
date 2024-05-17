function [TV, TE] = compar_old(a, t0, T, N, f)
    // lignes : Euler, pt milieu, RK4
    TV = zeros(3, N+1)
    TV(1, :) = eulerexpl(a, t0, T, N, f)
    TV(2, :) = pointmilieu(a, t0, T, N, f)
    TV(3, :) = RK4(a, t0, T, N, f)
    
    t = linspace(t0, T, N+1)
    x = (3/2)*exp(-t) - 0.5*cos(t) + 0.5*sin(t) // x(t)
    for (i = 1:3)
        TE(i, :) = abs(x - TV(i, :))
    end
endfunction

function [TV, TE] = compar(a, t0, T, f)
    // lignes : Euler, pt milieu, RK4
    TV = zeros(3, 4)
    N = [10, 100, 1000, 10000]
    for (i = 1:4)
        TV(1, i) = eulerexpl(a, t0, T, N(i), f)(N(i))
        TV(2, i) = pointmilieu(a, t0, T, N(i), f)(N(i))
        TV(3, i) = RK4(a, t0, T, N(i), f)(N(i))
    end
    
    t = T
    x = (3/2)*exp(-t) - 0.5*cos(t) + 0.5*sin(t) // x(t)
    TE = TV - x
endfunction

