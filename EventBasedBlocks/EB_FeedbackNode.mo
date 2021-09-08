within PEBC_multisample.EventBasedBlocks;

model EB_FeedbackNode
  parameter SI.Time q=0.01 "time quantum (sync with sensor)";
  parameter Integer npast = 2;
  Modelica.Blocks.Interfaces.RealInput r annotation(
    Placement(visible = true, transformation(origin = {-180, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput y[npast+1] annotation(
    Placement(visible = true, transformation(origin = {-170, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput e[npast+1] annotation(
    Placement(visible = true, transformation(origin = {180, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
protected
  discrete Real rVec[npast+1];
algorithm
  when sample(0,q) then
    rVec := cat(1,{r},rVec[1:end-1]);
    e := rVec-y;
  end when;  
initial algorithm
  rVec := r*ones(npast+1); 
  e := rVec-y;
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {1, 37}, extent = {{-17, 15}, {17, -15}}, textString = "EB"), Line(origin = {-2, 0}, points = {{-80, 0}, {80, 0}}, thickness = 0.5), Line(origin = {0, -42}, points = {{0, -40}, {0, 40}}, thickness = 0.5), Ellipse(origin = {-9, -11}, fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-11, 31}, {29, -9}}, endAngle = 360), Text(origin = {-18, -35}, extent = {{-40, 27}, {38, -37}}, textString = "-"), Text(origin = {-40, -15}, extent = {{-32, 25}, {32, -25}}, textString = "+")}, coordinateSystem(initialScale = 0.1)));
end EB_FeedbackNode;