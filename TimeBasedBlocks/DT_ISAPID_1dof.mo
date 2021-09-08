within PEBC_multisample.TimeBasedBlocks;

model DT_ISAPID_1dof "exp(-s*theta/(1-theta))/(1+s)"
  extends BaseClasses.BaseTBblock;
  parameter Real K=1;
  parameter Real Ti=5;
  parameter Real Td=0.5;
  parameter Real N=4;
  parameter Real ymax=1;
  parameter Real ymin=-ymax;
  parameter Real q=0.01;
protected
  discrete Real yp,yy,uold(start=0,fixed=true);
  discrete Real yi,yiold(start=0,fixed=true);
  discrete Real yd,ydold(start=0,fixed=true);
equation
  y = yy;
algorithm
  when sample(0,q) then
    yp    := K*u;
    yi    := yiold+K*q/Ti*u;
    yd    := (Td*ydold+K*N*Td*(u-uold))/(Td+N*q);
    yy    := yp+yi+yd;
    uold  := u;
    yiold := yi;
    ydold := yd;
    if y>ymax then
       yy    := ymax;
       yiold := yy-yp;
       ydold := 0;
    end if;
    if y<ymin then
       yy    := ymin;
       yiold := yy-yp;
       ydold := 0;
    end if;
  end when;
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-22, 22}, extent = {{-50, 28}, {92, -68}}, textString = "ISAPID\nDT")}, coordinateSystem(initialScale = 0.1)));
end DT_ISAPID_1dof;