function[x] = solinf(L,b)
    //Fonction qui résoud le système Lx = b
    [nL,mL] = size(L);
    [nB,mB] = size(b);
    
    //Check validity of matricial product
    if (mL <> nB || mB <> 1) then
        error("erreur dans solinf, dimensions non conformes !");
    end
    
    //Execution of the program
    x = zeros(nB,1);
    
    for i=1:nB
        
        //Error if pivot is equal to 0
        if abs(L(i,i)) <= %eps
            error("erreur dans solinf, pivot nul");
        end
        
        x(i,1) =  1/L(i,i);
        c = b(i,1);
        for j=1:i-1
            c = c - L(i,j) * x(j,1);
        end
        x(i,1) = x(i,1) * c;
    end
    
endfunction

function [x] = solsup(U, b)
    [n m] = size(U)
    x = zeros(n,1)
    for i=n:-1:1
        if U(i, i) == 0
            error("Matrice non inversible")
        end
        s = 0
        for j = n:-1:i
            s = s + U(i, j) * x(j)
        end
        //s = s + U(i, n:-1:i) * x(n:-1:i)
        x(i) = (b(i) - s) / U(i, i)
    end
endfunction

function [C] = cholesky(a)
    [na, ma] = size(a);
    
    C = zeros(na,ma);

    if (a(1,1) < %eps) then
        error("Error in Cholesky, element is null");
    end
    
    C(1,1) = sqrt(a(1,1));
    for j = 2 : na
        C(j,1) = a(j,1) / C(1,1);
    end
    for i = 2 : na
        somme = 0;
        somme = somme + (C(i,1:i-1)) * (C(i,1:i-1))';
        
        if ((a(i,i) -somme) < %eps) then
            error("Error in Cholesky, sqrt not possible");
        end
        C(i,i) = sqrt(a(i,i) - somme);
        
        for j = i+1 : na
            somme = 0;
            somme = somme + C(j,1:i-1)*C(i,1:i-1)';
            if (C(i,i) < %eps) then
                error("Error in Cholesky, division by 0");
            end
            C(j,i) = (a(j,i) - somme)/C(i,i);
        end 
    end

    
endfunction

function [x] = resolchol(A, b)
    C = cholesky(A);
    y = solinf(C,b);
    x = solsup(C',y);
endfunction
