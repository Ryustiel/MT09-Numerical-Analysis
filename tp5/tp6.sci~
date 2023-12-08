exec('G:\GitHub\MT09\tp5\calc.sci', -1)
exec('G:\GitHub\MT09\tp6\construct.sci', -1)
exec('G:\GitHub\MT09\tp6\mcnorm.sci', -1)

t = [0; 1; 3; 4; 5.5; 6]
tau = [0.5; 2; 2.5; 3.5; 4.5; 5.75]
y = [1; 1.5; 1.25; 0; 0; 1.5]

//t = [0; 1; 3; 4; 5.5; 6]
//tau = (0:0.3:6)'
//y = [0; 0.6; 1.4; 1.7; 2.1; 1.9; 1.6; 1.4; 1.4; 1; 0.5; 0.4; -0.2; -0.8; -0.5; 0; 0.4; 1; 1.6; 1.7; 1.2]

A1 =  construct(t1,tau1)
z1 = mcnorm(A1, y1)
n =  size(t)(1)
scf(2)
for i=1:n-1
    points = linspace(t(i),t(i+1), 20)
    plot(points,construct(t,points')*z1) 
end
plot(tau,y,'ro')


courbe(y, tau, 100, t(2))


x = linspace(min(tau), max(tau), 100)
cc = calcoef(tau, y)
// disp(size(cc))
gx = calcgv(x, tau, cc)
plot(x, gx, 'r')
