function [A] = construct(t, tau)
   m = size(tau)(1)
   n = size(t)(1)
   A = zeros(m,n)
   for i=1:m
       for j=1:n-1
           if tau(i)>=t(j) & tau(i)<=t(j+1) then
               A(i,j+1)=(tau(i)-t(j))/(t(j+1)-t(j))
               A(i,j)=(tau(i)-t(j+1))/(t(j)-t(j+1))
               break
           end    
       end
   end
endfunction
