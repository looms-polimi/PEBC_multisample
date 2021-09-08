within PEBC_multisample.Functions;

function Dr_5051
  "Dr interpolation for Dpm=5, kc=0.5 and ka=1"
  extends Modelica.Icons.Function;
  input Real theta;
  output Integer Dr;
algorithm
 Dr := integer(
         ceil( 35.076111
              -49.914933*theta
              -172.64193*theta^2
              +1493.7916*theta^3
              -4491.7198*theta^4
              +6678.6432*theta^5
              -4857.3197*theta^6
              +1378.6972*theta^ 7
         )
       );      
end Dr_5051;