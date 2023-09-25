function B = inverse(A)
    // tests preliminaires d'inversibilite
    // construit une matrice identite aux dimensions de A
    [m,n] = size(A)
    if (m ~= n)
        error("MATRICE NON CARREE !");
    end

    I = eye(n,n)
    B = zeros(n,n)

    for i=1 : n
        B(:,i) = resolLU(A,I(:,i))
    end
endfunction
