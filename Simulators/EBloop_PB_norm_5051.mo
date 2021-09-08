within PEBC_multisample.Simulators;

model EBloop_PB_norm_5051
  "EB loop with norm benchmark P (a,b,theta), Dpm=5, kc=0.5, and ka=1"
  constant  Real Dpm = 5;
  constant  Real kc = 0.5;
  constant  Real ka = 1;
  parameter Real a = 1;
  parameter Real b = 0.8;
  parameter Real theta = 0;
  parameter Real An=0.02 "ampliture of noise on y";
  parameter Real Delta = 0.01 "SOD threshold";
  parameter Real to_muls[:] = {10, 20, 50, 100, 200, 500};
  parameter Integer to_dex_start = 6;
  parameter Real tstep = 1e-9;
  final parameter Real q(fixed=false);
  final parameter Real wc(fixed=false);
  final parameter Integer Dr(fixed=false);
  Real w=SetPoint.y;
  Real y=anoise.y;
  Real u=P.u;
  Real thetaFOPDT=D/(D+T);
  Boolean trasClk=EG.trasClk;
  Integer trasCnt=EG.trasCount;
  Modelica.Blocks.Noise.TruncatedNormalNoise Noise(samplePeriod = q / 5, useAutomaticLocalSeed = true, useGlobalSeed = true, y_max = An, y_min = -An)  annotation(
    Placement(visible = true, transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add anoise annotation(
    Placement(visible = true, transformation(origin = {32, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  final parameter Real mu(fixed=false);
  final parameter Real T(fixed=false);
  final parameter Real D(fixed=false);
  final parameter Real lambda(fixed=false);
  final parameter Real K(fixed=false);
  final parameter Real Ti(fixed=false);
  final parameter Real Td(fixed=false);
  final parameter Real N(fixed=false);
  Modelica.Blocks.Sources.RealExpression SetPoint(y =  0) annotation(
    Placement(visible = true, transformation(origin = {-170, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression LoadDist(y = if time < tstep then 0 else 1)  annotation(
    Placement(visible = true, transformation(origin = {-170, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add aLD annotation(
    Placement(visible = true, transformation(origin = {-50, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PEBC_multisample.EventBasedBlocks.EB_FeedbackNode fb(q = q) annotation(
    Placement(visible = true, transformation(origin = {-130, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PEBC_multisample.EventBasedBlocks.EB_ISAPID_1dof PID(K = K, N = N, Td = Td, Ti = Ti, q = q, ymax = 1e8, ymin = -1e8) annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PEBC_multisample.TimeBasedBlocks.Proc_PB_norm P(a = a, b = b, theta = theta) annotation(
    Placement(visible = true, transformation(origin = {-10, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PEBC_multisample.EventGenerators.ClockedEG_OnDelta_TimeOut EG(DeltaMinus = -Delta, DeltaPlus = Delta, ntras = Dr, q = q, to_dex_start = to_dex_start, to_muls = to_muls) annotation(
    Placement(visible = true, transformation(origin = {70, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
  (mu,T,D) = Functions.MoA_LS_PB(a,b,theta);
  lambda = (T+D/5)/ka;
  (K,Ti,Td,N) = Functions.PID_IMC_CT(mu,T,D,lambda);
  (q,wc) = Functions.qwc(T,D,lambda,Dpm,kc);
  Dr = Functions.Dr_5051(thetaFOPDT);
equation
  connect(LoadDist.y, aLD.u1) annotation(
    Line(points = {{-159, 50}, {-70, 50}, {-70, 22}, {-62, 22}}, color = {0, 0, 127}));
  connect(SetPoint.y, fb.r) annotation(
    Line(points = {{-159, 10}, {-140, 10}}, color = {0, 0, 127}));
  connect(fb.e, PID.u) annotation(
    Line(points = {{-120, 10}, {-100, 10}}, color = {0, 0, 127}, thickness = 0.5));
  connect(PID.y, aLD.u2) annotation(
    Line(points = {{-80, 10}, {-62, 10}}, color = {0, 0, 127}));
  connect(aLD.y, P.u) annotation(
    Line(points = {{-39, 16}, {-20, 16}}, color = {0, 0, 127}));
  connect(EG.yVec, fb.y) annotation(
    Line(points = {{80, 22}, {90, 22}, {90, -10}, {-130, -10}, {-130, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(EG.trasClk, PID.trig) annotation(
    Line(points = {{80, 28}, {90, 28}, {90, 40}, {-110, 40}, {-110, 16}, {-100, 16}}, color = {255, 0, 255}));
  connect(P.y, anoise.u2) annotation(
    Line(points = {{0, 16}, {20, 16}}, color = {0, 0, 127}));
  connect(anoise.y, EG.u) annotation(
    Line(points = {{44, 22}, {60, 22}}, color = {0, 0, 127}));
  connect(Noise.y, anoise.u1) annotation(
    Line(points = {{-38, 70}, {10, 70}, {10, 28}, {20, 28}, {20, 28}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.01),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian,newInst",
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end EBloop_PB_norm_5051;