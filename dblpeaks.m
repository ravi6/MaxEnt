function dblpeaks

h = figure ;
grid on ;
%V =-[0.01/2, 0.1, 0.3, 0.5, 1, 3, 5, 10]';
V = [0.05, 0.3, 0.5, 10]';

 for i = 1:size(V)
  T = V(i) ;
  z = quad(@(x)g(x,T), -0.6, 0.6) ;
  lambda = T * ( log(z) - 1) ;
  Intpx = quad(@(x)p(x, lambda, T), -0.6, 0.6) ;
  fexp = quad(@(x)pf(x, lambda, T), -0.6, 0.6) ;
  A(i,:) = [T, lambda, fexp, Intpx]; 

  xx = [-0.6:(1.2/100):0.6];
  yy = p(xx, lambda, T);
  hold on; 
  str = sprintf(";T=%6.3f lambda=%6.3f fexp=%6.3f;", T, lambda, fexp);
  plot(xx,yy,str, "linewidth", 3);
  plot([-0.5, -0.5],[0, 1], "--", "linewidth", 2);
  plot([0.5, 0.5],[0, 1], "--", "linewidth", 2);
 end
 printf("T\tlambda\tfExp\tIntp(x)\n");
A

end

function ans = f(x)  #The function to max/min
    ans = 8 * (1 - 2 * x .* x) .* x .* x ;
end

function ans = g(x, T)
   ans = exp ( - f(x) / T ) ;
end

function ans = p(x, lambda, T)  # The probability dis
   z = 1 + (lambda/T) + f(x)/T ;
   ans = exp (-z) ; 
end

function ans = pf(x, lambda, T) # function to g6.1et expected value
    ans = p(x, lambda, T) * f(x) ;
end

