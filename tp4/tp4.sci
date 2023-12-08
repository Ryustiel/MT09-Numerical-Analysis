function courbe(N)
    //Plot the circle
    //center of the circle
    xc = 0;
    yc = 0;
    //radius of the circle
    r = 2;
    //dummy variable for angle in range [0, 2*%pi]
    a = linspace(0, 2*%pi, N);

    //x axis
    x = xc + r*cos(a);
    //y axis
    y = yc + r*sin(a);
    //plot the circle
    plot(x, y);
    
    
    //Plot exp(x)
    x1 = linspace(-2, 2, N);
    x2=exp(x1)
    plot(x1,x2)

endfunction


