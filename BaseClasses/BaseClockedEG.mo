within PEBC_multisample.BaseClasses;
  
model BaseClockedEG
  parameter SI.Time q=0.01 "internal clock period";
  parameter Integer npast=2 "past values (plus current) of y to transmit";
  parameter Integer ntras=3 "transmissions to make when an event is triggered";
  Modelica.Blocks.Interfaces.RealInput u "input" annotation(
    Placement(visible = true, transformation(origin = {-112, 4}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput trasClk "toggles at transmissions" annotation(
    Placement(visible = true, transformation(origin = {92, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  discrete Modelica.Blocks.Interfaces.RealOutput yVec[npast+1] "present and past y, most recent 1st" annotation(
    Placement(visible = true, transformation(origin = {38, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  discrete Integer evCount "event counter";
  discrete Integer trasCount "transmissions counter";
protected
  discrete Integer tras_to_go "per-event transmission ctr";
  discrete Real y "present sample";
  discrete Real yBuf[npast+1] "internal buffer for past y";
initial algorithm
  y := u;
  yBuf := ones(npast+1)*u;
  yVec := yBuf;
  trasClk := false;
  evCount := 0;
  trasCount := 0;
  tras_to_go := 0;
annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Rectangle(fillColor = {170, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-68, 79}, extent = {{-30, 23}, {34, -7}}, textString = "EG_clk")}, coordinateSystem(initialScale = 0.1)));
end BaseClockedEG;