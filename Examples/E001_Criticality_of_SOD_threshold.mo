within PEBC_multisample.Examples;

model E001_Criticality_of_SOD_threshold
  parameter Real a = 0;
  parameter Real b = 0.7;
  parameter Real theta = 0.8;
  parameter Real An = 0.02;
  parameter Real DeltaDrComp = 0.5;
  parameter Real DeltaDrFix1 = 0.005;
  parameter Real DeltaDrFix2 = 0.010;
  parameter Real DeltaDrFix3 = 0.025;


  PEBC_multisample.Simulators.EBloop_PB_norm_5051 LoopDrComp
     (An = An, Delta = DeltaDrComp, a = a, b = b, theta = theta)
     annotation(
    Placement(visible = true, transformation(origin = {-60, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PEBC_multisample.Simulators.EBloop_PB_norm_fixedDr LoopDrFixDy1
     (An = An, Delta = DeltaDrFix1, Dr = 1, a = a, b = b, theta = theta)
     annotation(
    Placement(visible = true, transformation(origin = {-60, 24}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PEBC_multisample.Simulators.EBloop_PB_norm_fixedDr LoopDrFixDy2
     (An = An, Delta = DeltaDrFix2, Dr = 1, a = a, b = b, theta = theta)
     annotation(
    Placement(visible = true, transformation(origin = { -60, -24}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PEBC_multisample.Simulators.EBloop_PB_norm_fixedDr LoopDrFixDy3
     (An = An, Delta = DeltaDrFix3, Dr = 1, a = a, b = b, theta = theta)
     annotation(
    Placement(visible = true, transformation(origin = {-60, -72}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation

annotation(
    experiment(StartTime = 0, StopTime = 120, Tolerance = 1e-6, Interval = 1),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian,newInst",
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "euler", emit_protected = "()"));
end E001_Criticality_of_SOD_threshold;