within PEBC_multisample.EventBasedBlocks;

model EB_ISAPID_1dof "from BaseEBblock with n=2,m=3"
/*
C  : K*(1+1/s/Ti+s*Td/(1+s*Td/N));
Cd : rat(subst(s=(z-1)/z/q,C),z);
a1 : (2*Td*Ti+q*Ti*N)/(Td*Ti+q*Ti*N);
a2 : -Td*Ti/(Td*Ti+q*Ti*N);
b0 : ((q^2+(Td+q)*Ti)*K*N+(q*Td+Td*Ti)*K)/(Td*Ti+q*Ti*N);
b1 : ((-q-2*Td)*Ti*K*N+(-q*Td-2*Td*Ti)*K)/(Td*Ti+q*Ti*N);
b2 : (Td*Ti*K+Td*Ti*K*N)/(Td*Ti+q*Ti*N);
ck : rat((b0+b1/z+b2/z^2)/(1-a1/z-a2/z^2)-Cd);
*/
  extends BaseClasses.BaseEBblock(n=2,m=3);
  parameter Real K;
  parameter Real Ti;
  parameter Real Td;
  parameter Real N;
  parameter Real q;
  parameter Real ymax;
  parameter Real ymin;
protected
  discrete Real yy;
algorithm
  when change(trig) then
    uVec := u;
    yy :=  {(2*Td*Ti+q*Ti*N)/(Td*Ti+q*Ti*N),-Td*Ti/(Td*Ti+q*Ti*N)}*yVec
          +{((q^2+(Td+q)*Ti)*K*N+(q*Td+Td*Ti)*K)/(Td*Ti+q*Ti*N),
            ((-q-2*Td)*Ti*K*N+(-q*Td-2*Td*Ti)*K)/(Td*Ti+q*Ti*N),
            (Td*Ti*K+Td*Ti*K*N)/(Td*Ti+q*Ti*N)}*uVec;
    y := max(ymin,min(ymax,yy));
    yVec := cat(1,{y},yVec[1:end-1]);
  end when;
initial algorithm
  yy := 0;
  
annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-4, -2}, extent = {{-62, 54}, {62, -54}}, textString = "ISA PID
1dof")}, coordinateSystem(initialScale = 0.1)));
end EB_ISAPID_1dof;