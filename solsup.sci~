function [x] = solsup(U, b)
    sizeM=size(U, "c");
    tol=1.d-16;
    if size(U,1) < 1 then
        error("La matrice ne doit pas être vide.");
    end
    if size(b, "c") ~= 1 then
        error("Le deuxième argument doit être un vecteur");
    end
    if sizeM ~=  size(b, "r") then
        error("La matrice doit être de la même taille que le vecteur.");
    end
    x=zeros(sizeM,1);
    for i=sizeM:-1:1
        if abs(U(i,i))<tol then
            error("La matrice n''est pas inversible.");
        end
        s=0;
        for j=sizeM:-1:i
            s=s+U(i,j)*x(j);
        end
        x(i)=(b(i)-s)/U(i,i);
    end
endfunction
