within PEBC_multisample.Functions;

function PID_IMC_CT "IMC PID continuous-time tuning rule"
  extends Modelica.Icons.Function;
  input Real mu, T, D, lambda;
  output Real K, Ti, Td, N;
protected
  Real eta;
algorithm
  Ti := T + D ^ 2 / (2 * (lambda + D));
  K := Ti / (mu * (lambda + D));
  N := T * (lambda + D) / (lambda * Ti) - 1;
  Td := lambda * D * N / (2 * (lambda + D));
  
  eta := D/(D+lambda);
  Modelica.Utilities.Streams.print("K="+String(K)
                                   +", Ti="+String(Ti)
                                   +", Td="+String(Td)
                                   +", N="+String(N)
                                   +", eta="+String(eta));
end PID_IMC_CT;