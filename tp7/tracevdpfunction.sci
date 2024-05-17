function tracevdpfunction()
    scf(1)
    theta = linspace(t0,t0+N, 1000)
    Z_ode = ode(a, t0, theta, vdp)
    plot(theta, Z_ode(1, :))
    title("vdp approximée")
endfunction
