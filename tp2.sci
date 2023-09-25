function assert(condition, message)
    if ~condition then
        error(message);
    end
endfunction

function X = solinf(L, b, tolerance)
    // taille de la matrice
    [n, m] = size(L)
    assert(n == m, "la matrice nest pas carree")
    X = zeros(n)
    for k = 1:n
        assert(L(k, k) > tolerance, "Coefficient nul sur la diagonale {" + string(k) + "}")
        X(k) = b(k) / L(k, k)
        if k < n then
            for i = k+1:n
                b(i) = b(i) - b(k) * L(i, k) / L(k, k)
            end
        end
    end
endfunction

M = [24, 0, 0, 0; 24, 6, 0, 0; 12, 6, 2, 0; 4, 3, 2, 1;]
b = [24, 18, 8, 2]

// M = [1, 0, 0; 2, 1, 0; 3, 4, 1]
// b = [1, 2, 3]

tolerance = 1.d-16

solinf(M, b, tolerance)
