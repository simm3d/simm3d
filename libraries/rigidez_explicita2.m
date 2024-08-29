function KE=rigidez_explicita2(v,E,coord,conec)
%RIGIDEZ_EXPLICITA2 Calculate the local stiffness matrix explicitly
%
%KE=RIGIDEZ_EXPLICITA2(v,E,coord,conec)
%
%InputS
%  v      >>  Element type, type = 1 Tetrahedron; type = 3 hexahedron
%  E      >>  node coordinates in the x direction
%  coord  >>  Coordinate matrix
%  conec  >>  node coordinates in the z direction
%
%Outputs
%  conecKe >>  Connectivity matrix for the use of sparse_create technique
%  coords  >>  Coordinate matrix
%  lnods   >>  Connectivity matrix
%  nel     >>  Number of elements
%  nn      >>  Number of nodes
%  ndof    >>  Total number of degree of free
%  c       >>  Centroid of the elements
%  mat     >>  Contains the flags of the elements of each region
[b1,b2,b3,b4,c1,c2,c3,c4,d1,d2,d3,d4]=coeficientes(coord,conec);

b1c1=b1.*c1;
b2c1=b2.*c1;
b3c1=b3.*c1;
b4c1=b4.*c1;
b1c2=b1.*c2;
b2c2=b2.*c2;
b3c2=b3.*c2;
b4c2=b4.*c2;
b1c3=b1.*c3;
b2c3=b2.*c3;
b3c3=b3.*c3;
b4c3=b4.*c3;
b1c4=b1.*c4;
b2c4=b2.*c4;
b3c4=b3.*c4;
b4c4=b4.*c4;

 b1d1= b1.*d1;
 b2d1= b2.*d1;
 b3d1= b3.*d1;
 b4d1= b4.*d1;
 b1d2= b1.*d2;
 b2d2= b2.*d2;
 b3d2= b3.*d2;
 b4d2= b4.*d2;
 b1d3= b1.*d3;
 b2d3= b2.*d3;
 b3d3= b3.*d3;
 b4d3= b4.*d3;
 b1d4= b1.*d4;
 b2d4= b2.*d4;
 b3d4= b3.*d4;
 b4d4= b4.*d4;

 c1d1=c1.*d1;
 c2d1=c2.*d1;
 c3d1=c3.*d1;
 c4d1=c4.*d1;
 c1d2=c1.*d2;
 c2d2=c2.*d2;
 c3d2=c3.*d2;
 c4d2=c4.*d2;
 c1d3=c1.*d3;
 c2d3=c2.*d3;
 c3d3=c3.*d3;
 c4d3=c4.*d3;
 c1d4=c1.*d4;
 c2d4=c2.*d4;
 c3d4=c3.*d4;
 c4d4=c4.*d4;
 
 b1b1= b1.*b1;
 %b2b1= b2.*b1;
 %b3b1= b3.*b1;
 %b4b1= b4.*b1;
 b1b2= b1.*b2;
 b2b2= b2.*b2;
 %b3b2= b3.*b2;
 %b4b2= b4.*b2;
 b1b3= b1.*b3;
 b2b3= b2.*b3;
 b3b3= b3.*b3;
 %b4b3= b4.*b3;
 b1b4= b1.*b4;
 b2b4= b2.*b4;
 b3b4= b3.*b4;
 b4b4= b4.*b4;
 
 c1c1=c1.^2;
 %c1c2=c1.*c2;
 %c1c3= c1.*c3;
 %c1c4=c1.*c4;
 c1c2=c1.*c2;
 c2c2= c2.^2;
 %c2c3= c2.*c3;
 %c2c4= c2.*c4;
 c1c3= c1.*c3;
 c2c3= c2.*c3;
 c3c3=  c3.^2;
 %c3c4= c3.*c4;
 c1c4= c1.*c4;
 c2c4= c2.*c4;
 c3c4= c3.*c4;
 c4c4= c4.^2;
 
 d1d1=d1.^2;
 %d2d1=d1.*d2;
 %d3d1= d1.*d3;
 %d4d1= d1.*d4;
 d1d2= d1.*d2;
 d2d2= d2.^2;
 %d3d2= d2.*d3;
 %d4d2= d2.*d4;
 d1d3= d1.*d3;
 d2d3= d2.*d3;
 d3d3= d3.^2;
 %d4d3=d3.*d4;
 d1d4=d1.*d4;
 d2d4=d2.*d4;
 d3d4=d3.*d4;
 d4d4=d4.^2;
 VV=volume_tetra(conec,coord);
E=E(:)';

K11= (E.*(2*b1b1*v + 2*c1c1*v + 2*d1.^2*v - 2*b1b1 - c1c1 - d1d1))./(72*VV*(2*v^2 + v - 1));

K12=-(E.*b1c1)./(72*VV*(2*v^2 + v - 1));

K13= -(E.*b1d1)./(72*VV*(2*v^2 + v - 1));

K14=-(E.*(2*b1b2 + c1c2 + d1d2 - 2*b1b2*v - 2*c1c2*v - 2*d1d2*v))./(72*VV*(2*v^2 + v - 1));

K15=-(E.*(b2c1 + 2*b1.*c2*v - 2*b2c1*v))./(72*VV*(2*v^2 + v - 1));

K16=-(E.*(b2d1 + 2*b1.*d2*v - 2*b2d1*v))./(72*VV*(2*v^2 + v - 1));

K17=-(E.*(2*b1b3 + c1c3 + d1d3 - 2*b1b3*v - 2*c1c3*v - 2*d1d3*v))./(72*VV*(2*v^2 + v - 1));

K18=-(E.*(b3c1 + 2*b1.*c3*v - 2*b3c1*v))./(72*VV*(2*v^2 + v - 1));

K19=-(E.*(b3d1 + 2*b1d3*v - 2*b3d1*v))./(72*VV*(2*v^2 + v - 1));

K110=-(E.*(2*b1b4 + c1c4 + d1d4 - 2*b1b4*v - 2*c1c4*v - 2*d1d4*v))./(72*VV*(2*v^2 + v - 1));

K111=-(E.*(b4c1 + 2*b1c4*v - 2*b4c1*v))./(72*VV*(2*v^2 + v - 1));                               

K112=-(E.*(b4d1 + 2*b1d4*v - 2*b4d1*v))./(72*VV*(2*v^2 + v - 1));
                 
K22=(E.*(2*b1.^2*v + 2*c1.^2*v + 2*d1.^2*v - b1.^2 - 2*c1.^2 - d1.^2))./(72*VV*(2*v^2 + v - 1));

K23=-(E.*c1d1)./(72*VV*(2*v^2 + v - 1));

K24=-(E.*(b1c2 - 2*b1c2*v + 2*b2c1*v))./(72*VV*(2*v^2 + v - 1));

K25=-(E.*(b1b2 + 2*c1c2 + d1d2 - 2*b1b2*v - 2*c1c2*v - 2*d1d2*v))./(72*VV*(2*v^2 + v - 1));

K26=-(E.*(c2d1 + 2*c1d2*v - 2*c2d1*v))./(72*VV*(2*v^2 + v - 1));

K27=-(E.*(b1c3 - 2*b1.*c3*v + 2*b3.*c1*v))./(72*VV*(2*v^2 + v - 1));

K28=-(E.*(b1b3 + 2*c1c3 + d1d3 - 2*b1b3*v - 2*c1c3*v - 2*d1d3*v))./(72*VV*(2*v^2 + v - 1));

K29=-(E.*(c3d1 + 2*c1d3*v - 2*c3d1*v))./(72*VV*(2*v^2 + v - 1));

K210=-(E.*(b1c4 - 2*b1c4*v + 2*b4c1*v))./(72*VV*(2*v^2 + v - 1));

K211=-(E.*(b1b4 + 2*c1c4 + d1d4 - 2*b1b4*v - 2*c1c4*v - 2*d1d4*v))./(72*VV*(2*v^2 + v - 1));

K212=-(E.*(c4d1 + 2*c1d4*v - 2*c4d1*v))./(72*VV*(2*v^2 + v - 1));

K33=(E.*(2*b1b1*v + 2*c1c1*v + 2*d1d1*v - b1b1 - c1c1 - 2*d1d1))./(72*VV*(2*v^2 + v - 1));

K34=-(E.*(b1d2 - 2*b1d2*v + 2*b2d1*v))./(72*VV*(2*v^2 + v - 1));

K35=-(E.*(c1d2 - 2*c1d2*v + 2*c2d1*v))./(72*VV*(2*v^2 + v - 1));

K36= -(E.*(b1b2 + c1c2 + 2*d1d2 - 2*b1b2*v - 2*c1c2*v - 2*d1d2*v))./(72*VV*(2*v^2 + v - 1));

K37=-(E.*(b1d3 - 2*b1d3*v + 2*b3d1*v))./(72*VV*(2*v^2 + v - 1));

K38=-(E.*(c1d3 - 2*c1d3*v + 2*c3d1*v))./(72*VV*(2*v^2 + v - 1));

K39=-(E.*(b1b3 + c1c3 + 2*d1d3 - 2*b1b3*v - 2*c1c3*v - 2*d1d3*v))./(72*VV*(2*v^2 + v - 1));

K310=-(E.*(b1d4 - 2*b1d4*v + 2*b4d1*v))./(72*VV*(2*v^2 + v - 1));

K311=-(E.*(c1d4 - 2*c1d4*v + 2*c4d1*v))./(72*VV*(2*v^2 + v - 1));

K312=-(E.*(b1b4 + c1c4 + 2*d1d4 - 2*b1b4*v - 2*c1c4*v - 2*d1d4*v))./(72*VV*(2*v^2 + v - 1));
 
K44= (E.*(2*b2b2*v + 2*c2c2*v + 2*d2d2*v - 2*b2b2 - c2c2 - d2d2))./(72*VV*(2*v^2 + v - 1));

K45=-(E.*b2c2)./(72*VV*(2*v^2 + v - 1));

K46=-(E.*b2d2)./(72*VV*(2*v^2 + v - 1));

K47=-(E.*(2*b2b3 + c2c3 + d2d3 - 2*b2b3*v - 2*c2c3*v - 2*d2d3*v))./(72*VV*(2*v^2 + v - 1));

K48=-(E.*(b3c2 + 2*b2c3*v - 2*b3c2*v))./(72*VV*(2*v^2 + v - 1));

K49=-(E.*(b3d2 + 2*b2d3*v - 2*b3d2*v))./(72*VV*(2*v^2 + v - 1));

K410=-(E.*(2*b2b4 + c2c4 + d2d4 - 2*b2b4*v - 2*c2c4*v - 2*d2d4*v))./(72*VV*(2*v^2 + v - 1));

K411=-(E.*(b4c2 + 2*b2c4*v - 2*b4c2*v))./(72*VV*(2*v^2 + v - 1));

K412=-(E.*(b4d2 + 2*b2d4*v - 2*b4d2*v))./(72*VV*(2*v^2 + v - 1));

K55=(E.*(2*b2b2*v + 2*c2c2*v + 2*d2d2*v - b2b2 - 2*c2c2 - d2d2))./(72*VV*(2*v^2 + v - 1));

K56=-(E.*c2d2)./(72*VV*(2*v^2 + v - 1));

K57=-(E.*(b2c3 - 2*b2c3*v + 2*b3c2*v))./(72*VV*(2*v^2 + v - 1));

K58=-(E.*(b2b3 + 2*c2c3 + d2d3 - 2*b2b3*v - 2*c2c3*v - 2*d2d3*v))./(72*VV*(2*v^2 + v - 1));

K59=-(E.*(c3d2 + 2*c2d3*v - 2*c3d2*v))./(72*VV*(2*v^2 + v - 1));

K510=-(E.*(b2c4 - 2*b2c4*v + 2*b4c2*v))./(72*VV*(2*v^2 + v - 1));

K511=-(E.*(b2b4 + 2*c2c4 + d2d4 - 2*b2b4*v - 2*c2c4*v - 2*d2d4*v))./(72*VV*(2*v^2 + v - 1));

K512=-(E.*(c4d2 + 2*c2d4*v - 2*c4d2*v))./(72*VV*(2*v^2 + v - 1));
                             
K66=(E.*(2*b2b2*v + 2*c2c2*v + 2*d2d2*v - b2b2 - c2c2 - 2*d2d2))./(72*VV*(2*v^2 + v - 1));

K67=-(E.*(b2d3 - 2*b2d3*v + 2*b3d2*v))./(72*VV*(2*v^2 + v - 1));

K68=-(E.*(c2d3 - 2*c2d3*v + 2*c3d2*v))./(72*VV*(2*v^2 + v - 1));

K69=-(E.*(b2b3 + c2c3 + 2*d2d3 - 2*b2b3*v - 2*c2c3*v - 2*d2d3*v))./(72*VV*(2*v^2 + v - 1));

K610=-(E.*(b2d4 - 2*b2d4*v + 2*b4d2*v))./(72*VV*(2*v^2 + v - 1));

K611=-(E.*(c2d4 - 2*c2d4*v + 2*c4d2*v))./(72*VV*(2*v^2 + v - 1));

K612=-(E.*(b2b4 + c2c4 + 2*d2d4 - 2*b2b4*v - 2*c2c4*v - 2*d2d4*v))./(72*VV*(2*v^2 + v - 1));
                               
K77=(E.*(2*b3b3*v + 2*c3c3*v + 2*d3d3*v - 2*b3b3 - c3c3 - d3d3))./(72*VV*(2*v^2 + v - 1));

K78=-(E.*b3c3)./(72*VV*(2*v^2 + v - 1));

K79=-(E.*b3d3)./(72*VV*(2*v^2 + v - 1));

K710=-(E.*(2*b3b4 + c3c4 + d3d4 - 2*b3b4*v - 2*c3c4*v - 2*d3d4*v))./(72*VV*(2*v^2 + v - 1));

K711=-(E.*(b4c3 + 2*b3c4*v - 2*b4c3*v))./(72*VV*(2*v^2 + v - 1));

K712=-(E.*(b4d3 + 2*b3d4*v - 2*b4d3*v))./(72*VV*(2*v^2 + v - 1));

K88=(E.*(2*b3b3*v + 2*c3c3*v + 2*d3d3*v - b3b3 - 2*c3c3 - d3d3))./(72*VV*(2*v^2 + v - 1));

K89=-(E.*c3d3)./(72*VV*(2*v^2 + v - 1));

K810=-(E.*(b3c4 - 2*b3c4*v + 2*b4c3*v))./(72*VV*(2*v^2 + v - 1));

K811=-(E.*(b3b4 + 2*c3c4 + d3d4 - 2*b3b4*v - 2*c3c4*v - 2*d3d4*v))./(72*VV*(2*v^2 + v - 1));

K812=-(E.*(c4d3 + 2*c3d4*v - 2*c4d3*v))./(72*VV*(2*v^2 + v - 1));
                              
K99=(E.*(2*b3b3*v + 2*c3c3*v + 2*d3d3*v - b3b3 - c3c3 - 2*d3d3))./(72*VV*(2*v^2 + v - 1));

K910=-(E.*(b3d4 - 2*b3d4*v + 2*b4d3*v))./(72*VV*(2*v^2 + v - 1));

K911=-(E.*(c3d4 - 2*c3d4*v + 2*c4d3*v))./(72*VV*(2*v^2 + v - 1));

K912=-(E.*(b3b4 + c3c4 + 2*d3d4 - 2*b3b4*v - 2*c3c4*v - 2*d3d4*v))./(72*VV*(2*v^2 + v - 1));

K1010=(E.*(2*b4b4*v + 2*c4c4*v + 2*d4d4*v - 2*b4b4 - c4c4 - d4d4))./(72*VV*(2*v^2 + v - 1));

K1011=-(E.*b4c4)./(72*VV*(2*v^2 + v - 1));

K1012=-(E.*b4d4)./(72*VV*(2*v^2 + v - 1));
     
K1111=(E.*(2*b4b4*v + 2*c4c4*v + 2*d4d4*v - b4b4 - 2*c4c4 - d4d4))./(72*VV*(2*v^2 + v - 1));

K1112=-(E.*c4d4)./(72*VV*(2*v^2 + v - 1));
                           
K1212=(E.*(2*b4b4*v + 2*c4c4*v + 2*d4d4*v - b4b4 - c4c4 - 2*d4d4))./(72*VV*(2*v^2 + v - 1));
KE=[K11;K12;K13;K14;K15;K16;K17;K18;K19;K110;K111;K112;K12;K22;K23;K24;K25;K26;K27;K28;K29;K210;K211;K212;K13;K23;K33;K34;K35;K36;K37;K38;K39;K310;K311;K312;K14;K24;K34;K44;K45;K46;K47;K48;K49;K410;K411;K412;K15;K25;K35;K45;K55;K56;K57;K58;K59;K510;K511;K512;K16;K26;K36;K46;K56;K66;K67;K68;K69;K610;K611;K612;K17;K27;K37;K47;K57;K67;K77;K78;K79;K710;K711;K712;K18;K28;K38;K48;K58;K68;K78;K88;K89;K810;K811;K812;K19;K29;K39;K49;K59;K69;K79;K89;K99;K910;K911;K912;K110;K210;K310;K410;K510;K610;K710;K810;K910;K1010;K1011;K1012;K111;K211;K311;K411;K511;K611;K711;K811;K911;K1011;K1111;K1112;K112;K212;K312;K412;K512;K612;K712;K812;K912;K1012;K1112;K1212]; 
end

function [b1,b2,b3,b4,c1,c2,c3,c4,d1,d2,d3,d4]=coeficientes(coord,conec);

[X1,X2,X3,X4,Y1,Y2,Y3,Y4,Z1,Z2,Z3,Z4]=XYZ(coord,conec);

b1 =Y3.*Z2 - Y2.*Z3 + Y2.*Z4 - Y4.*Z2 - Y3.*Z4 + Y4.*Z3;
c1 =X2.*Z3 - X3.*Z2 - X2.*Z4 + X4.*Z2 + X3.*Z4 - X4.*Z3;
d1 =X3.*Y2 - X2.*Y3 + X2.*Y4 - X4.*Y2 - X3.*Y4 + X4.*Y3;

b2= Y1.*Z3 - Y3.*Z1 - Y1.*Z4 + Y4.*Z1 + Y3.*Z4 - Y4.*Z3;
c2= X3.*Z1 - X1.*Z3 + X1.*Z4 - X4.*Z1 - X3.*Z4 + X4.*Z3;
d2= X1.*Y3 - X3.*Y1 - X1.*Y4 + X4.*Y1 + X3.*Y4 - X4.*Y3;

b3= Y2.*Z1 - Y1.*Z2 + Y1.*Z4 - Y4.*Z1 - Y2.*Z4 + Y4.*Z2;
c3= X1.*Z2 - X2.*Z1 - X1.*Z4 + X4.*Z1 + X2.*Z4 - X4.*Z2;
d3= X2.*Y1 - X1.*Y2 + X1.*Y4 - X4.*Y1 - X2.*Y4 + X4.*Y2;

b4= Y1.*Z2 - Y2.*Z1 - Y1.*Z3 + Y3.*Z1 + Y2.*Z3 - Y3.*Z2;
c4= X2.*Z1 - X1.*Z2 + X1.*Z3 - X3.*Z1 - X2.*Z3 + X3.*Z2;
d4= X1.*Y2 - X2.*Y1 - X1.*Y3 + X3.*Y1 + X2.*Y3 - X3.*Y2;
end
% coordenadas does elementos

function VV=volume_tetra(conec,coord)

[X1,X2,X3,X4,Y1,Y2,Y3,Y4,Z1,Z2,Z3,Z4]=XYZ(coord,conec);

VV=  1/6*((X1).*(Y3).*(Z2) - (X1).*(Y2).*(Z3) + ...
    (X2).*(Y1).*(Z3) - (X2).*(Y3).*(Z1) - ...
    (X3).*(Y1).*(Z2) + (X3).*(Y2).*(Z1) + ...
    (X1).*(Y2).*(Z4) - (X1).*(Y4).*(Z2) - ...
    (X2).*(Y1).*(Z4) + (X2).*(Y4).*(Z1) + ...
    (X4).*(Y1).*(Z2) - (X4).*(Y2).*(Z1) - ...
    (X1).*(Y3).*(Z4) + (X1).*(Y4).*(Z3) + ...
    (X3).*(Y1).*(Z4) - (X3).*(Y4).*(Z1) - ...
    (X4).*(Y1).*(Z3) + (X4).*(Y3).*(Z1) + ...
    (X2).*(Y3).*(Z4) - (X2).*(Y4).*(Z3) - ...
    (X3).*(Y2).*(Z4) + (X3).*(Y4).*(Z2) + ...
    (X4).*(Y2).*(Z3) - (X4).*(Y3).*(Z2));
end

function [X1,X2,X3,X4,Y1,Y2,Y3,Y4,Z1,Z2,Z3,Z4]=XYZ(coord,conec)
X1=coord(conec(:,1)',1)'; Y1=coord(conec(:,1)',2)'; Z1=coord(conec(:,1)',3)';
X2=coord(conec(:,2)',1)'; Y2=coord(conec(:,2)',2)'; Z2=coord(conec(:,2)',3)';
X3=coord(conec(:,3)',1)'; Y3=coord(conec(:,3)',2)'; Z3=coord(conec(:,3)',3)';
X4=coord(conec(:,4)',1)'; Y4=coord(conec(:,4)',2)'; Z4=coord(conec(:,4)',3)';
end