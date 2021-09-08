within PEBC_multisample.EventGenerators;

model ClockedEG_OnDelta "Clocked send on delta, symmetric or asymmetric"
  extends BaseClasses.BaseClockedEG;
  parameter Real DeltaPlus = 0.01;
  parameter Real DeltaMinus = -DeltaPlus;
protected
  discrete Real y_last;
algorithm
  when sample(0, q) then
    yBuf := cat(1,{u},yBuf[1:end-1]);
    if u - y_last >= DeltaPlus or u - y_last <= DeltaMinus and tras_to_go==0 then
      tras_to_go := ntras;
      evCount := evCount+1;
    end if;
    if tras_to_go > 0 then
      y := u;
      y_last := y;
      yVec := yBuf;
      trasClk := not trasClk;
      trasCount := trasCount + 1;
      tras_to_go := tras_to_go-1;
    end if;
  end when;   
initial algorithm
  y_last := u;
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-11, 1}, extent = {{-49, 39}, {65, -45}}, textString = "Delta")}),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end ClockedEG_OnDelta;