function [i] = place(T,t) 
    [n,m] = size(T)
    if t<T(1,1)|t>T(n,1)  then
        error("t < T1 ou t > Tn");
    end
    imin = 1
    imax = n
    while (imax-imin)>1 
        mil = floor((imax+imin)/2)
        if t>=T(mil,1)
            imin = mil
        else
            imax = mil
        end
    end
    i = imin
endfunction

function [x]=rich(a,b,c,u)
    e(1) = -(c(1) / b(1));
    f(1) = (u(1) / b(1));
    s = size(u,"r");
    x = zeros(s,1);
    for i = 2:s - 1
        e(i) = -(c(i) / (a(i) * e(i - 1) + b(i)));
        f(i)=(u(i) - a(i) * f(i-1)) / (a(i) * e(i-1) + b(i));
    end
    f(s)=(u(s) - a(s) * f(s-1)) / (a(s) * e(s-1) + b(s));
    x(s) = f(s);
    for i = s - 1:-1:1
        x(i) = e(i) * x(i+1) + f(i);
    end
endfunction

function [d] = cald2(T,y)
    n=length(y);
    h(1) = T(2) - T(1);
    a(1) = 0;
    b(1) = 2/h(1);
    c(1) = 1/h(1);
    u(1) = 3 * ((y(2)-y(1))/(h(1)**2));
    for i = 2:n-1
        h(i) = T(i + 1) - T(i) ;
        a(i) = 1 / h(i-1);
        b(i) = 2 / h(i-1) + 2/h(i);
        c(i) = 1 / h(i);
        u(i) = 3 * ((y(i) - y(i-1)) / (h(i-1) ** 2) + (y(i+1) - y(i)) / (h(i) ** 2));
    end
    c(n) = 0;
    a(n) = 1/h(1);
    b(n) = 2/h(1);
    u(n) = 3* ((y(n) - y(n-1)) / (h(n-1) ** 2));
    disp(u);
    d = rich(a,b,c,u);
endfunction

function [C] = cholesky(A)
    [n,n] = size(A)
    C = zeros(n,n)
    for j = 1:n
        s = A(j,j)-sum(C(j,1:j-1)^2)
        if(s<=0) then
            error("Matrice non définie positive");
        end
        C(j,j)=sqrt(s)
        for i = j+1 : n
            C(i,j)=1/C(j,j)*(A(i,j)-sum(C(i,1:j-1).*C(j,1:j-1)))
        end
    end
    s = A(n,n)-sum(C(n,1:n-1)^2)
    if(s<=0) then
            error("Matrice non définie positive");
    end
    C(n,n)=sqrt(s)
endfunction

function [x] = solsup(U, b)
    //résoudre le système linéaire triangulaire supérieur Lx=b
    //vérifier les paramètres 
    [Um,Un] = size(U)
    [bm,bn] = size(b)
    
    if (bn ~= 1 | Um ~= bm | Um ~= Un)
        error("ERREUR PARAMETRE");
    end
    
    x = zeros(Un,1)
    tol = 2*10^(-16)
    
    for i = Um:-1:1
        if(abs(U(i,i)) < tol)
            error("Matrice non inversible")
        end
        S = 0 
        for j = i+1 : Um
            S = S + U(i,j)*x(j)
        end
        x(i) = (b(i) - S)/U(i,i)
    end
endfunction


function [x] = solinf(L, b)
    //résoudre le système linéaire triangulaire inférieur Lx=b
    //vérifier les paramètres 
    [Lm,Ln] = size(L)
    [bm,bn] = size(b)
    
    if (bn ~= 1 | Lm ~= bm | Lm ~= Ln)
        error("ERREUR PARAMETRE");
    end
    
    x = zeros(Ln,1)
    tol = 2*10^(-16)
    
    for i = 1 : Lm
        if(abs(L(i,i)) < tol)
            error("Matrice non inversible")
        end
        S = 0 
        for j = 1 : i-1
            S = S + L(i,j)*x(j)
        end
        x(i) = (b(i) - S)/L(i,i)
    end
endfunction


function [x] = resolchol(A,b)
    C = cholesky(A) //A=C*C' => C*C'*x=b 
    y = solinf(C, b)
    x = solsup(C', y)
endfunction

function [d]=cald(T,y)
    [mT,nT] = size(T)
    [my,ny] = size(y)
    if(mT~=my| nT~=1 |ny~=1) then
        error("Taille non correcte");
    end 
    n=mT
    h = zeros(n-1,1)
    //calculer h
    for i = 1 : n-1
        h(i,1)=T(i+1,1)-T(i,1)
    end
    A = zeros(n,n)
    u = zeros(n,1)
    //calculer A
    A(1,1)=2/h(1,1)
    A(1,2)=1/h(1,1)
    A(n,n)=2/h(n-1,1)
    A(n,n-1)=1/h(n-1,1)
    for i = 2:n-1
        A(i,i)=(2/h(i,1)+2/h(i-1,1))
        A(i,i-1)=1/h(i-1,1)
        A(i,i+1)=1/h(i,1)
    end
    //calculer u
    u(1,1)=3*(y(2,1)-y(1,1))/(h(1,1)^2)
    u(n,1)=3*(y(n,1)-y(n-1,1))/(h(n-1,1)^2)
    for j = 2:n-1
        u(j,1) = 3*((y(j,1)-y(j-1,1))/(h(j-1,1)^2)+(y(j+1,1)-y(j,1))/(h(j,1)^2))
    end
    //résoudre le système Ad=u
    d = resolchol(A,u)
endfunction


function [cc] = calcoef2(T,y)
    n = length(y);
    d = cald2(T,y);
    for i = 1:n-1
        h(i) = T(i+1) - T(i);
        cc(i,1) = y(i);
        cc(i,2) = d(i);
        cc(i,3) = (y(i+1) - y(i)) / (h(i) ** 2) - d(i)/h(i);
        cc(i,4) = (d(i+1) + d(i)) / (h(i) ** 2) - 2 * (y(i+1) - y(i)) / (h(i) ** 3);
    end
endfunction

function [cc]=calcoef(T,y)
    d = cald(T,y)
    for i = 1 : size(T)(1)-1
        h(i,1)=T(i+1,1)-T(i,1)
    end
    for i = 1:size(T)(1)-1
        cc(i,1)=y(i,1)
        cc(i,2)=d(i,1)
        cc(i,3)=((y(i+1,1)-y(i,1))/(h(i,1)^2))-(d(i,1)/h(i,1))
        cc(i,4)=((d(i+1,1)+d(i,1))/(h(i,1)^2))-2*((y(i+1,1)-y(i,1))/(h(i,1)^3))
    end
    
endfunction





function [z]=calcg(theta,t,cc)
    // cette fois t = theta, T = t, cc reste a calculer
    [m,n] = size(cc)
    s=size(t,"r")
    if(m <> s-1 | n <> 4) then
        error("Taille non correcte");
    end
    if theta == t(n-1) then
        z = horn(cc(i,1:n)',[t(n-1), t(n-1), t(n)], theta)(1)
    else
        i = place(t,theta)
        z = horn(cc(i,1:n)',[t(i), t(i), t(i+1)], theta)(1)
    end
    
endfunction



function [y] = calcgv(theta, t, cc) // calcule g(theta) pour un vecteur theta
    y = zeros(size(theta)(2))
    for i = 1:size(theta)(2)
        y(i) = calcg(theta(i), t, cc)
    end    
endfunction

function trace_interp_spline(t, y, Npt)
    x = linspace(min(t), max(t), Npt)
    
    courbe(y, t, Npt, t(2))
    
    cc = calcoef(t, y)

    gx = calcgv(x, t, cc)
    plot(x, gx)
    
    cc = calcoef2(t, y)

    gx = calcgv(x, t, cc)
    plot(x, gx)

endfunction

t = [1; 3; 4.5; 5; 6]
y = [1; 5; 3; 7; -1]
trace_interp_spline(t, y, 100)


