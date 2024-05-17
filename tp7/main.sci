//Penser à executer tous les fichier avant le main
exec("eulerexpl.sci")
exec("funexpt2.sci")
exec("tracevdp.sci")
exec("pointmilieu.sci")
exec("vdp.sci")
exec("RK4.sci")
exec("tracevdpfunction.sci")
exec("f.sci")
exec("compar.sci")


a= 0
t0 = 0
T = 5
N = 10

Z = eulerexpl(a, t0, T, N, funexpt2)
t=linspace(0,5,N+1)
y= 2*exp(t)-(t^2)-(2*t)-2
//Si y(t)=2e^t-t^2-2t-2, y'(t) = 2e^t-2t-2 = y(t)+t^2; 
//N = 10
//plot(t,Z,".b")
//plot(t,y,"r")
//title("N = 10. ROUGE = Solution Exacte, BLEU = approchée")


//N = 20
N1 = 20
Z1 = eulerexpl(a, t0, T, N1, funexpt2)
t1=linspace(0,5,N1+1)
y1= 2*exp(t1)-(t1^2)-(2*t1)-2
//scf(1)
//plot(t1,Z1,".b")
//plot(t1,y1,"r")
//title("N = 20. ROUGE = Solution Exacte, BLEU = approchée")


//N = 50
N2 = 50
Z2 = eulerexpl(a, t0, T, N2, funexpt2)
t2=linspace(0,5,N2+1)
y2= 2*exp(t2)-(t2^2)-(2*t2)-2
//scf(2)
//plot(t2,Z2,".b")
//plot(t2,y2,"r")
//title("N = 50. ROUGE = Solution Exacte, BLEU = approchée")

//On remarque que plus N est grand ici, plus la solution approchée s'approche de la solution exacte: la précision est accrue dans notre cas

//Partie 1
//On a posé: Y(t) = U'(t) et Y'(t)=c*(1-U(t)^2)*U'(t)-U(t) (deux équations du premier ordre)
a = [2;-2]
t0 = 0
T =15
N = 100
//tracevdp(a,t0,T, 2*N, N, 2*N, 4*N)
//tracevdpfunction()

[TV, TE] = compar(1, 0, 10, f)
theta = linspace(0, 10, size(TV)(2))
plot(theta, TV(1, :), 'b') // euler bleu
plot(theta, TV(2, :), 'r') // pt milieu rouge
plot(theta, TV(3, :), 'g') // RK4 vert

t = linspace(0, 10, 1000)
x = (3/2)*exp(-t) - 0.5*cos(t) + 0.5*sin(t) // x(t)
plot(t, x, 'y')

scf(2)
N = [10, 100, 1000, 10000]
//plot(log10(theta), -log10(TE(1, :)), "b")
plot(N, N*reglin(N, -log10(TE(1, :)), "b"))

//plot(log10(theta), -log10(TE(2, :)), "r")
plot(N, N*reglin(N, -log10(TE(2, :)), "r"))

//plot(log10(theta), -log10(TE(3, :)), "g")
plot(N, N*reglin(N, -log10(TE(3, :)), "g"))
