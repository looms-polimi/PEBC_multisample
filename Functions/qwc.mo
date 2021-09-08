within PEBC_multisample.Functions;

function qwc
  extends Modelica.Icons.Function;
  input Real T;
  input Real D;
  input Real lambda;
  input Real Dpm;
  input Real kc;
  output Real q;
  output Real wc;
protected
  Real theta,eta;
algorithm
  theta := D/(D+T);
  eta   := D/(D+lambda);
  wc    := T*theta/(1+theta)/sqrt(2)/eta
           *sqrt(eta^2-2*eta-3
             +sqrt(17*eta^4-36*eta^3+14*eta^2+12*eta+9)
            );
  q     := Dpm/180*Modelica.Constants.pi/kc/wc;
end qwc;