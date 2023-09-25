function [L,U] = LU(A)
    sizeM = size(A, "c");
    L = eye(sizeM, sizeM);
    U = zeros(sizeM, sizeM);
    if size(A) == [0,0] then
        error("La matrice ne doit pas Ãªtre vide.");
    end
    for i = 1:sizeM - 1
        for j = 1:sizeM
            if i == 1 then
                s = L(i,1) * U(1,j);
            else
                s = L(i,1:i-1) * U(1:i-1,j);
            end
            U(i,j) = A(i,j) - s;
        end
        for j = i+1:sizeM
            if i == 1 then
                s = L(j,1) * U(1,i);
            else
                s = L(j,1:i-1) * U(1:i-1,i);
            end
            L(j,i) = 1 / U(i,i) * (A(j,i) - s);
        end
    end
    if sizeM == 1 then
        s = L(sizeM, 1) * U(1, sizeM)
    else
        s = L(sizeM, 1:sizeM - 1) * U(1:sizeM - 1, sizeM);
    end
    U(sizeM, sizeM) = A(sizeM, sizeM) - s;
endfunction
