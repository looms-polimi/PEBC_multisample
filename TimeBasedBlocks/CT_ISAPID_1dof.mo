within PEBC_multisample.TimeBasedBlocks;

model CT_ISAPID_1dof "exp(-s*theta/(1-theta))/(1+s)"
  extends BaseClasses.BaseTBblock;
  parameter Real K=1;
  parameter Real Ti=5;
  parameter Real Td=0.5;
  parameter Real N=4;
  parameter Real ymax=1;
  parameter Real ymin=-ymax;
  Modelica.Blocks.Continuous.Derivative D(T = Td / N, initType = Modelica.Blocks.Types.Init.InitialOutput, k = Td, x(fixed = false), y_start = 0)  annotation(
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder FB(T = Ti, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 1, y(fixed = false), y_start = 0)  annotation(
    Placement(visible = true, transformation(origin = {-30, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gK(k = K)  annotation(
    Placement(visible = true, transformation(origin = {-128, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add ipfb annotation(
    Placement(visible = true, transformation(origin = {-70, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter satI(limitsAtInit = true, uMax = ymax, uMin = ymin)  annotation(
    Placement(visible = true, transformation(origin = {-30, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter satO(limitsAtInit = true, uMax = ymax, uMin = ymin) annotation(
    Placement(visible = true, transformation(origin = {72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add aD annotation(
    Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder OF(T = Ti / 20, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 1, y(fixed = false), y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {128, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(u, gK.u) annotation(
    Line(points = {{-180, 0}, {-140, 0}, {-140, 0}, {-140, 0}}, color = {0, 0, 127}));
  connect(gK.y, ipfb.u1) annotation(
    Line(points = {{-116, 0}, {-82, 0}}, color = {0, 0, 127}));
  connect(ipfb.y, satI.u) annotation(
    Line(points = {{-58, -6}, {-42, -6}, {-42, -6}, {-42, -6}}, color = {0, 0, 127}));
  connect(satI.y, aD.u2) annotation(
    Line(points = {{-18, -6}, {18, -6}}, color = {0, 0, 127}));
  connect(satI.y, FB.u) annotation(
    Line(points = {{-18, -6}, {0, -6}, {0, -40}, {-18, -40}, {-18, -40}}, color = {0, 0, 127}));
  connect(FB.y, ipfb.u2) annotation(
    Line(points = {{-42, -40}, {-100, -40}, {-100, -12}, {-82, -12}, {-82, -12}}, color = {0, 0, 127}));
  connect(gK.y, D.u) annotation(
    Line(points = {{-116, 0}, {-100, 0}, {-100, 30}, {-42, 30}, {-42, 30}}, color = {0, 0, 127}));
  connect(D.y, aD.u1) annotation(
    Line(points = {{-18, 30}, {0, 30}, {0, 6}, {18, 6}}, color = {0, 0, 127}));
  connect(aD.y, satO.u) annotation(
    Line(points = {{42, 0}, {58, 0}, {58, 0}, {60, 0}}, color = {0, 0, 127}));
  connect(satO.y, OF.u) annotation(
    Line(points = {{84, 0}, {114, 0}, {114, 0}, {116, 0}}, color = {0, 0, 127}));
  connect(OF.y, y) annotation(
    Line(points = {{140, 0}, {164, 0}, {164, 0}, {180, 0}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-22, 22}, extent = {{-50, 28}, {92, -68}}, textString = "ISAPID")}, coordinateSystem(initialScale = 0.1)));
end CT_ISAPID_1dof;