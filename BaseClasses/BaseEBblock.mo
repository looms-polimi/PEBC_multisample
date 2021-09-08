within PEBC_multisample.BaseClasses;

model BaseEBblock
  parameter Integer n=2;
  parameter Integer m=2;
  Modelica.Blocks.Interfaces.BooleanInput trig annotation(
    Placement(visible = true, transformation(origin = {-180, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u[m] annotation(
    Placement(visible = true, transformation(origin = {-180, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {180, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
protected
  discrete Real yVec[n];
  discrete Real uVec[m]; 
initial algorithm
  y := 0;
  yVec := zeros(n);
  uVec := zeros(m);
annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Rectangle(origin = {0, -1}, fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {79, 87}, extent = {{-17, 15}, {17, -15}}, textString = "EBB")}));
end BaseEBblock;