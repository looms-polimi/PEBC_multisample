within PEBC_multisample.TimeBasedBlocks;

model Proc_FOPDT "mu*exp(-s*D/(1+sT)"
  extends BaseClasses.BaseTBblock;
  parameter Real mu;
  parameter Real T;
  parameter Real D;
  Modelica.Blocks.Nonlinear.FixedDelay del(delayTime = D)  annotation(
    Placement(visible = true, transformation(origin = {-72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder rat(T = T, k = mu, y(fixed = true))  annotation(
    Placement(visible = true, transformation(origin = {48,0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(u, del.u) annotation(
    Line(points = {{-180, 0}, {-86, 0}, {-86, 0}, {-84, 0}}, color = {0, 0, 127}));
  connect(del.y, rat.u) annotation(
    Line(points = {{-60, 0}, {34, 0}, {34, 0}, {36, 0}, {36, 0}}, color = {0, 0, 127}));
  connect(rat.y, y) annotation(
    Line(points = {{60, 0}, {164, 0}, {164, 0}, {180, 0}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-24, 16}, extent = {{-50, 28}, {92, -68}}, textString = "FOPDT\nnorm")}));
end Proc_FOPDT;