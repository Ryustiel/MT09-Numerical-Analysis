function tracevdp(a,t0,T, Neul, Nptmil, Node, Nrk4)
    scf(1)
    
    //Point Milieu
    Z_mil = pointmilieu(a,t0,T,Nptmil, vdp)
    x1 = Z_mil(1,:)
    x2 = Z_mil(2,:)
    plot(x1,x2,'r')
    title('Pointmilieu : N=100');
    
    //Euler explicite
    Z_eul = eulerexpl(a,t0,T,Neul, vdp)
    x1 = Z_eul(1,:)
    x2 = Z_eul(2,:)
    plot(x1,x2,'b')
    title('Euler explicite (BLEU) et Pointmilieu (ROUGE) : N=100');
    
    //Ode
    theta = linspace(t0,t0+T, Node+1)
    Z_ode = ode(a, t0, theta, vdp)
    x1 = Z_ode(1,:)
    x2 = Z_ode(2,:)
    plot(x1,x2,'g')
    title('Euler explicite (BLEU) et Pointmilieu (ROUGE) Ode (VERT): N=100');
    
    //RK4
    Z_RK4 = RK4(a,t0,T,Nrk4, vdp)
    x1 = Z_RK4(1,:)
    x2 = Z_RK4(2,:)
    plot(x1,x2,'y')
    title('RK4 : N=100');
endfunction
