function [x] = solinf(L, b)
    tol=1.d-16;
    sizeM=size(L, "c");
    if size(L) == (0,0) then
        error("La matrice ne doit pas être vide.");
    end
    if size(b, "c") ~= 1 then
        error("Le deuxième argument doit être un vecteur");
    end
    if sizeM ~=  size(b, "r") then
        error("La matrice doit être de la même taille que le vecteur.");
    end
    x=zeros(sizeM,1);
    for i = 1:sizeM
        if abs(L(i,i))<tol then
            error("La matrice n''est pas inversible.");
        end
        s = 0;
        for j = 1:i-1
            s = s + L(i,j) * x(j);
        end
        x(i) = (b(i) - s) / L(i,i);
    end
endfunction
