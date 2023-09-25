function [U,e] = trisup(A, b)
    tol=1.d-16;
    sizeM=size(A, "c");
    if size(A,1) < 1 then
        error("La matrice ne doit pas être vide.");
    end
    if size(b, "c") ~= 1 then
        error("Le deuxième argument doit être un vecteur");
    end
    if sizeM ~=  size(b, "r") then
        error("La matrice doit être de la même taille que le vecteur.");
    end
    x=zeros(sizeM,1);
    for k=1:sizeM-1
        if abs(A(k,k))<tol then
            error("La matrice n''est pas inversible.");
        end
        for i=k+1:sizeM
            c=A(i,k)/A(k,k);
            b(i)=b(i)-c*b(k);
            A(i,k)=0;
            for j=k+1:sizeM
                A(i,j)=A(i,j)-c*A(k,j);
            end
        end
    end
    if abs(A(sizeM,sizeM))<tol then
        error("La matrice n''est pas inversible.");
    end
    U=A;
    e=b;
endfunction
