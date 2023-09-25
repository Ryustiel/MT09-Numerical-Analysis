// les fonctions resol mettent en chaine differents composants
// pour resoudre un probleme donné

function [x]=resolG(A,b)
    [U,e]=trisup(A,b);
    x=solsup(U,e);
endfunction

function [x]=resolLU(A,b)
    [L,U] = LU(A)
    y = solinf(L,b)
    x = solsup(U,y)
endfunction
