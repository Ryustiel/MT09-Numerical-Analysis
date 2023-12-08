function [A] = constrpoly(tau)
    m = size(tau)(1);
    A = zeros(m,3);
    A(:,1)=ones(m,1);
    A(:,2)=tau;
    A(:,3)=tau.*tau    
endfunction
