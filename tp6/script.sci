/*
//prepaTP6
exec("C:\Users\utcpret\Downloads\MT09 TP6\constrpoly.sci", -1)
exec("C:\Users\utcpret\Downloads\MT09 TP6\mcnormprepa.sci", -1)
//Par les moindres carrés (minimisation, m>n), et n est le degré du polynome+1 (sa dimension)
//Application1
tau=[0;1;2]
y=[3;-3;6]
A=constrpoly(tau)
x=mcnorm(A,y)
disp(x)
scf(1)
//on trouve une courbe de la forme x0+x1t+x2t^2
//=>1+t+t^2
p=-3:0.1:5
plot(p,constrpoly(p')*x) //parabole des valeurs qui approchent la fonction
plot(tau,y,"ro") //graphique des valeurs donnes.


//Application2
tau2=(0:0.25:2)'
y2 = [-1, -0.71, 0.94, 1.82, 3.02, 2.94, 1.44, 0.82, -0.62]'
A2=constrpoly(tau2)
x2=mcnorm(A2,y2)
disp(x2)
p2=-2:0.05:4
scf(2)
plot(p2,constrpoly(p2')*x2)
plot(tau2,y2,"ro")
*/

//TP6

/*
//1.

//APP1
exec("C:\Users\utcpret\Downloads\MT09 TP6\construct.sci", -1)
t1 = [0; 1 ; 3 ; 4 ; 5.5 ; 6] 
tau1 = t1
A1 =  construct(t1,tau1)
disp(A1)
//APP2
t2 = [0; 1; 3; 4; 5.5; 6]
tau2 = [0.5; 2; 2.5; 3.5; 4.5; 5.75]
A2 =  construct(t2,tau2)
disp(A2)
//APP3
t3 = [0; 1; 3; 4; 5.5; 6]
tau3=(0:0.3:6)'
A3 =  construct(t3,tau3)
disp(A3)
*/

/*
//2.
exec("C:\Users\utcpret\Downloads\MT09 TP6\mcnorm.sci", -1)

//APP1
t1 = [0; 1; 3; 4; 5.5; 6]
tau1 = [0.5; 2; 2.5; 3.5; 4.5; 5.75]
A1 =  construct(t1,tau1)
y1 = [1; 1.5; 1.25; 0; 0; 1.5]
z1 = mcnorm(A1, y1)
n =  size(t1)(1)
scf(2)
for i=1:n-1
    points = linspace(t1(i),t1(i+1), 20)
    plot(points,construct(t1,points')*z1) 
end
plot(tau1,y1,'ro')

//APP2
t2 = [0; 1; 3; 4; 5.5; 6]
tau2=(0:0.3:6)'
A2 =  construct(t2,tau2)
y2 = [0; 0.6; 1.4; 1.7; 2.1; 1.9; 1.6; 1.4; 1.4; 1; 0.5; 0.4; -0.2; -0.8; -0.5; 0; 0.4; 1; 1.6; 1.7; 1.2]
z2 = mcnorm(A2, y2)
n =  size(t2)(1)
scf(3)
for i=1:n-1
    points = linspace(t2(i),t2(i+1), 20)
    plot(points,construct(t2,points')*z2) 
end
plot(tau2,y2,'ro')

condM=cond((A2')*A2)
disp(condM)
*/

/*
//3


a)
A=Q*R 
Q' = 1/Q  => Q*Q' = I //car Q ortogonale 
=> Q'*A=R avec R la matrice par bloc compose par R° tri sup et 0
A*x=b  <=> Q*R*x=b //on multiplie par Q'
R*x=Q'*b
on s'interesse au solution de R°x=c ou R° est la matrice tri sup et c est le vecteur compose de n premier elements de b
*/

/*
exec("C:\Users\utcpret\Downloads\MT09 TP6\mcQR.sci", -1)
t = [0; 1; 3; 4; 5.5; 6]
tau=(0:0.3:6)'
A =  construct(t,tau)
y = [0; 0.6; 1.4; 1.7; 2.1; 1.9; 1.6; 1.4; 1.4; 1; 0.5; 0.4; -0.2; -0.8; -0.5; 0; 0.4; 1; 1.6; 1.7; 1.2]
z = mcQR(A, y)
n =  size(t)(1)
scf(4)
for i=1:n-1
    points = linspace(t(i),t(i+1), 20)
    plot(points,construct(t,points')*z) 
end
plot(tau,y,'ro')
//Les deux fonctions sont égales, donc la solution approximée est la meme
condM=cond((A')*A)
disp(condM) //le conditionement de R est la moitie du M, ce qui nous dit que R est plus stable et qu'une petite perturbation en M donnerai des grandes perturbations dans la solution.
*/
