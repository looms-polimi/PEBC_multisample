within PEBC_multisample.TimeBasedBlocks;

model Proc_PB_norm "(1-as)*exp(-s*theta/(1-theta))/(1+s)/(1+bs)/(1+b^2s)"
  extends BaseClasses.BaseTBblock;
  parameter Real a=0;
  parameter Real b=0.5;
  parameter Real theta=0;
  Modelica.Blocks.Nonlinear.FixedDelay del(delayTime = theta / (1 - theta))  annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Real x[3](each start=0,each fixed=true);
equation
  x[1]+der(x[1]) = (a+1)*del.y;
  x[2]+b*der(x[2]) = x[1]-a*del.y;
  x[3]+b^2*der(x[3]) = x[2];
  y = x[3];
  connect(u, del.u) annotation(
    Line(points = {{-180, 0}, {-134, 0}, {-134, 0}, {-132, 0}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-4,-2}, extent = {{-52, 56}, {52, -56}}, textString = "PB")}));
end Proc_PB_norm;