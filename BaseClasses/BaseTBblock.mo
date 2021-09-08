within PEBC_multisample.BaseClasses;

partial model BaseTBblock
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-180, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {180, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-78, 82}, extent = {{-24, 16}, {24, -16}}, textString = "PB"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
end BaseTBblock;