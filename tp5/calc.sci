exec('G:\GitHub\MT09\tp5\tp5.sci', -1)

function [i] = place(T,t) 
    [n,m] = size(T)
    // disp("PLACE DEBUG", T, t, t < T(1,1), T(1, 1), t > T(n,1))
    if t < T(1,1) | t > T(n,1)  then
        error("t < T1 ou t > Tn")
    end
    imin = 1
    imax = n
    while (imax-imin)>1 
        mil = floor((imax+imin)/2)
        if t >= T(mil,1)
            imin = mil
        else
            imax = mil
        end
    end
    i = imin
endfunction

function [x]=rich(a,b,c,u)
    e(1) = -(c(1) / b(1))
    f(1) = (u(1) / b(1))
    s = size(u,"r")
    x = zeros(s,1)
    for i = 2:s - 1
        e(i) = -(c(i) / (a(i) * e(i - 1) + b(i)))
        f(i)=(u(i) - a(i) * f(i-1)) / (a(i) * e(i-1) + b(i))
    end
    f(s)=(u(s) - a(s) * f(s-1)) / (a(s) * e(s-1) + b(s))
    x(s) = f(s)
    for i = s - 1:-1:1
        x(i) = e(i) * x(i+1) + f(i)
    end
endfunction

function [d] = cald(T,y)
    n=length(y)
    h(1) = T(2) - T(1)
    a(1) = 0
    b(1) = 2/h(1)
    c(1) = 1/h(1)
    u(1) = 3 * ((y(2)-y(1))/(h(1)**2))
    for i = 2:n-1
        h(i) = T(i + 1) - T(i) 
        a(i) = 1 / h(i-1)
        b(i) = 2 / h(i-1) + 2/h(i)
        c(i) = 1 / h(i)
        u(i) = 3 * ((y(i) - y(i-1)) / (h(i-1) ** 2) + (y(i+1) - y(i)) / (h(i) ** 2))
    end
    c(n) = 0;
    a(n) = 1/h(1)
    b(n) = 2/h(1)
    u(n) = 3* ((y(n) - y(n-1)) / (h(n-1) ** 2))
    d = rich(a,b,c,u)
endfunction


function [cc] = calcoef(T,y)
    n = length(y)
    d = cald(T,y)
    for i = 1:n-1
        h(i) = T(i+1) - T(i)
        cc(i,1) = y(i)
        cc(i,2) = d(i)
        cc(i,3) = (y(i+1) - y(i)) / (h(i) ** 2) - d(i)/h(i)
        cc(i,4) = (d(i+1) + d(i)) / (h(i) ** 2) - 2 * (y(i+1) - y(i)) / (h(i) ** 3)
    end
endfunction


function [z]=calcg(theta,t,cc)
    // cette fois t = theta, T = t, cc reste a calculer
    [m,n] = size(cc)
    s = size(t, "r")
    //if(m <> s-1 | n <> 4) then
        //error("Taille non correcte")
    //end
    // disp("theta debug", theta, t(n-1), theta == t(n-1))
    if theta == t(n-1) then
        z = horn(cc(n,1:n)',[t(n-1), t(n-1), t(n)], theta)
    else
        i = place(t,theta)
        z = horn(cc(i,1:n)',[t(i), t(i), t(i+1)], theta)
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
    plot(x, gx, 'r')
endfunction

function trace_lin(n, Tmax, Npt)
    t = linspace(-Tmax, Tmax, 2*n) // points d'interpolation
    f = (1 + t^2)^(-1)
    
    // disp("PRE COURBE CORRECT", t, f)
    courbe(f, t, Npt, t(2))
    
    x = linspace(-Tmax, Tmax, Npt)
    t = linspace(-Tmax, Tmax, 2*n + 1)' // points d'interpolation
    f = (1 + t^2)^(-1)
    // disp("PRE CALCGV CORRECT", t, f)

    cc = calcoef(t, f)
    disp(size(cc))
    gx = calcgv(x, t, cc)
    plot(x, gx, 'r')
    plot(t, f, 'ro')
    
    x = linspace(-Tmax, Tmax, Npt) // abscisse de l'affichage
    y = (1 + x^2)^(-1)
    plot(x, y, 'g')
endfunction

function trace_cheb(n, Tmax, Npt)
    t = -Tmax*cos((2*linspace(0, 2*n, 2*n) + 1)*%pi/(4*n + 2))
    f = (1 + t^2)^(-1)
    
    x = linspace(min(t), max(t), Npt) // abscisse de l'affichage
    
    courbe(f, t, Npt, t(2))
    
    t = -Tmax*cos((2*linspace(0, 2*n, 2 * n + 1) + 1)*%pi/(4*n + 2))
    f = (1 + t^2)^(-1)
    cc = calcoef(t, f)
    // disp(size(cc))
    gx = calcgv(x, t', cc)
    plot(x, gx, 'r')
    plot(t, f, 'or')
    
    y = (1 + x^2)^(-1)
    plot(x, y, 'g')
endfunction

//t = [1; 3; 4.5; 5; 6]
//y = [1; 5; 3; 7; -1]

t = linspace(0, 10, 11)
t = t / 10
y = [0; 0; 0; 0; 0; 0; 10; 0; 0; 0; 0]
disp(t', y)
//trace_interp_spline(t', y, 100)

//trace_lin(5, 5, 1000)

trace_cheb(5, 10, 1000)

