function sinx

plotfx() ;

h = figure ;
grid on ;
%V =-[0.01/2, 0.1, 0.3, 0.5, 1, 3, 5, 10]';
V = [0.05, 0.3, 0.5, 10]';

 for i = 1:size(V)
  T = V(i) ;
  z = quad(@(x)g(x,T), 0, pi) ;
  lambda = T * ( log(z) - 1) ;
  Intpx = quad(@(x)p(x, lambda, T), 0, pi) ;
  fexp = quad(@(x)pf(x, lambda, T), 0, pi) ;
  A(i,:) = [T, lambda, fexp, Intpx]; 

  xx = [0:pi/100:pi];
  yy = p(xx, lambda, T);
  hold on; 
  str = sprintf(";T=%6.3f lambda=%6.3f fexp=%6.3f;", T, lambda, fexp);
  plot(xx,yy,str, "linewidth", 3);
  plot([pi/2,pi/2],[0,2], "linewidth", 2);
 end
 printf("T\tlambda\tfExp\tIntp(x)\n");
A

end

function ans = f(x)  #The function to max/min
    ans = sin(x) ;
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

function plotfx()
  h = figure ;
  xlabel("x") ; ylabel("sin(x)");
  ylim([0,1.1]);
  x=[0:pi/100:pi]; y = sin(x);
  plot(x,y,'linewidth',3);
  hold on;
  plot([0,pi],[0,0],'or','markersize',6);
  grid on;
  pause ;
end

