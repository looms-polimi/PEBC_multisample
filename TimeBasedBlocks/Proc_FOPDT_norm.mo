within PEBC_multisample.TimeBasedBlocks;

model Proc_FOPDT_norm "exp(-s*theta/(1-theta))/(1+s)"
  extends BaseClasses.BaseTBblock;
  parameter Real theta(min=0,max=0.999)=0.2 annotation(Evaluate = true);
protected
  Real x(start=0,fixed=true);
equation
  x+der(x) = delay(u,theta/(1-theta));
  y = x;
annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-24, 16}, extent = {{-50, 28}, {92, -68}}, textString = "FOPDT\nnorm")}));
end Proc_FOPDT_norm;