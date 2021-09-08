within PEBC_multisample.EventGenerators;

model ClockedEG_OnDelta_TimeOut "Clocked send on delta, symmetric or asymmetric"
  extends BaseClasses.BaseClockedEG;
  parameter Real DeltaPlus = 0.01;
  parameter Real DeltaMinus = -DeltaPlus;
  parameter Real[:] to_muls = {5, 10, 20, 50, 100} "timeout vals in qs";
  parameter Integer to_dex_start = 1 "index of initial timeout mul";
  discrete Real timeOut;
protected
  discrete Real y_last, t_last;
  discrete Integer to_dex;
algorithm
  when sample(0, q) then
    yBuf := cat(1, {u}, yBuf[1:end - 1]);
    if (u - y_last >= DeltaPlus or u - y_last <= DeltaMinus or time - t_last >= timeOut) and tras_to_go == 0 then
      if time - t_last >= timeOut then
        to_dex := min(to_dex + 1, size(to_muls, 1));
      else
        to_dex := 1;
      end if;
      timeOut := q * to_muls[to_dex];
      tras_to_go := ntras;
      t_last := time;
      evCount := evCount + 1;
    end if;
    if tras_to_go > 0 then
      y := u;
      y_last := y;
      yVec := yBuf;
      trasClk := not trasClk;
      trasCount := trasCount + 1;
      tras_to_go := tras_to_go - 1;
    end if;
  end when;
initial algorithm
  y_last := u;
  t_last := time;
  to_dex := to_dex_start;
  timeOut := q * to_muls[to_dex];
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-15, 5}, extent = {{-53, 45}, {73, -51}}, textString = "Delta"), Rectangle(origin = {0, -80}, fillColor = {255, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -20}, {100, 20}}), Text(origin = {-3, -80}, extent = {{-57, 16}, {57, -16}}, textString = "TimeOut")}, coordinateSystem(initialScale = 0.1)),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian,newInst",
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end ClockedEG_OnDelta_TimeOut;