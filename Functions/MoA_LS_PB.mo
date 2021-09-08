within PEBC_multisample.Functions;

function MoA_LS_PB
  extends Modelica.Icons.Function;
  input Real a,b,theta;
  output Real mu,T,D;
protected
  Real a0,a1;
algorithm
  a0  :=  b^2+b+a+1;
  a1  :=  ((a+1)*exp(-b^2-b-a-1)
           -(b^3+a*b^2+b^2+a*b)*exp(-b-a/b-1/b-1)
           +(b^5+a*b^3)*exp(-1/b-a/b^2-1/b^2-1))
         /((b-1)^2*(b+1));
  mu  :=  1;
  D   :=  (a0-exp(1)*a1)/mu;
  T   :=  a0/mu-D;
  D   := D+theta/(1-theta);
end MoA_LS_PB;