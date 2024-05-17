function Y=vdp(t,X)
    Y(1)=X(2)
    Y(2)=0.4*(1-(X(1)^2))*X(2) - X(1)
endfunction
