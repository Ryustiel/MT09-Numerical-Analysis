function z=mcQR(A,y)
    [n,m]=size(A)
    [Q,R]=qr(A)
    disp(cond(R))
    b=Q'*y
    r=zeros(m,m)
    for i=1:m
        for j=1:m
            r(i,j)=R(i,j)
        end
        c(i)=b(i)
    end
    z=solsup(r,c)
endfunction
