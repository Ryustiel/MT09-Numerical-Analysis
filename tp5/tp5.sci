function [f] = diffdiv(y,t)
    n=length(t)-1
    for i=0:n
        f(i+1)=y(i+1);
    end
    for k=1:n
        for i=n:-1:k //remontée
            f(i+1)=(f(i+1)-f(i))/(t(i+1)-t(i-k+1));
        end
    end
    
endfunction

function [p, pprim] = horn(a, t, theta)
    n = size(a)(1)
    p = a(n)
    pprim = 0
    for k = n-1 : -1 : 1 // formule du cours
        pprim = pprim * (theta - t(k)) + p // on peut exprimer p+' = f(p')
        p = a(k)+(theta - t(k))*p
    end
endfunction

function [p] = hornv(a, t, theta)
    p = zeros(size(theta)(1))
    for i = 1:size(theta)(1) // applique horn pour chaque theta
        p(i) = horn(a, t, theta(i)) // dernier resultat = p
    end
endfunction

function [p] = interpol(y, t, theta)
    a = diffdiv(y, t) // pour avoir les coefficients
    p = hornv(a, t, theta) // calcul des valeurs de P aux points theta
endfunction

function courbe(y, t, N, tau)
    x = linspace(min(t), max(t), N)
    [p, pprim] = horn(diffdiv(y, t), t, tau) // pour tangente
    b = p - pprim * tau // on cherche le biais par rapport au point d'abscisse tau
    plot(x, interpol(y, t, x')) // polynome P(x)
    // plot(x, x * pprim + b) // tangente
    
    plot(t, y, 'bo')
endfunction

function application2(N, tau)
    t = linspace(-5, 5, N+1)
    f = (1 + t^2)^(-1)
    
    courbe(f, t, 1000, tau)
    
    // calcul de f
    t = linspace(-5, 5, 1000)
    f = (1 + t^2)^(-1)
    
    fprim = -2*tau / (1 + tau^2)^2 // coef directeur de la tangente en tau
    b = ((1 + tau^2)^(-1)) - fprim * tau // intercept
    plot(t, f)
    // plot(t, b + fprim * t, 'r')
endfunction

// Retour sur les fonctions du TP3

// application2(10, 4)


// TESTING

f = diffdiv([10; 12; 14; 16], [0; 1; 2; 3])

[p, pprim] = horn(f, t, 2)

a = [1; 3; 5; -1]
t = [0; 0; 1]
theta = [2; 4; 1]
y = hornv(a, t, theta)

y = [1; 5; 3; 7; -1]
t = [1; 3; 4.5; 5; 6]
res = interpol(y, t, [3; 4])

// courbe(y, t, 100, 4)










