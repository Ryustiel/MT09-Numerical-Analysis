//Penser à executer tous les fichier avant le main
exec("funexpt2.sci")

function [Z] = eulerexpl(a, t0, T, N, f)
    h = T/N
    p = size(a,'r')
    Z = zeros(p, N+1)
    Z(1) = a
    for n=1:N
        Z(n+1)=Z(n)+h*f(t0+n*h,Z(n))
    end
endfunction

a= 0
t0 = 0
T = 5
N = 10

Z = eulerexpl(a, t0, T, N, funexpt2)
t=linspace(0,5,N+1)
y= 2*exp(t)-(t^2)-(2*t)-2
//Si y(t)=2e^t-t^2-2t-2, y'(t) = 2e^t-2t-2 = y(t)+t^2; 
//N = 10
plot(t,Z,".b")
plot(t,y,"r")
title("N = 10. ROUGE = Solution Exacte, BLEU = approchée")


//N = 20
N1 = 20
Z1 = eulerexpl(a, t0, T, N1, funexpt2)
t1=linspace(0,5,N1+1)
y1= 2*exp(t1)-(t1^2)-(2*t1)-2
scf(1)
plot(t1,Z1,".b")
plot(t1,y1,"r")
title("N = 20. ROUGE = Solution Exacte, BLEU = approchée")


//N = 50
N2 = 50
Z2 = eulerexpl(a, t0, T, N2, funexpt2)
t2=linspace(0,5,N2+1)
y2= 2*exp(t2)-(t2^2)-(2*t2)-2
scf(2)
plot(t2,Z2,".b")
plot(t2,y2,"r")
title("N = 50. ROUGE = Solution Exacte, BLEU = approchée")
