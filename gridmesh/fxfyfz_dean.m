function [fx,fy,fz,simbox] = fxfyfz_dean(l1,l2,l3,l4,l5,l6,l7,l8,N1,N2,N3,N4,N11,N22)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%  Total length of the rock region
 Lx=ft2m(N1*l8+N2*l6+N1*l8);          % Length in the x direction in meter
 Ly=ft2m(N1*l6+N2*l5+N1*l6);          % Length in the y direction in meter                     
 Lz=ft2m(sum([l8 l7 l6 l4 l3])+...    % Length in the z direction in meter
               N3*l1 + N4*l2);
           
% Total length of the reservoir region
%
box1_min= ft2m(N1*l8);                % Right side of the reservoir
box1_max= ft2m(N1*l8+N2*l6);          % Left  side of the reservoir
%
box2_min= ft2m(N1*l6);                % Front side of the reservoir
box2_max= ft2m(N1*l6+N2*l5);          % Rear  side of the reservoir
%
box3_min= ft2m(N4*l2);                % Bottom side of the reservoir
box3_max= ft2m(N4*l2+N1*l1);          % Top    side of the reservoir
%
simbox=[box1_min box1_max; box2_min box2_max; box3_min box3_max ];
% N11=5;    % Grid number in the x direction of the left and right side rocks
% N22=11;   % Grid number in the x and y direction in the reservoir region
% Generate the grid using the fxfyfzdean
[fx, fy, fz] = fxfyfzdean(N11,N22,N3,N4,box1_min,box1_max,box2_min,box2_max,...
                          l1,l2,l3,l4,l6,l7,l8,Lx,Ly);
end
function [fx, fy, fz] = fxfyfzdean(N1,N2,N3,N4,box1_min,box1_max,box2_min,box2_max,l1,l2,l3,l4,l6,l7,l8,Lx,Ly)
fx=[0:box1_min /N1:box1_min  (box1_min +(box1_max-box1_min )/N2):(box1_max-box1_min )/N2:box1_max (box1_max+(Lx-box1_max)/N1):(Lx-box1_max)/N1:Lx];
fy=[0:box2_min /N1:box2_min  (box2_min +(box2_max-box2_min )/N2):(box2_max-box2_min )/N2:box2_max (box2_max+(Ly-box2_max)/N1):(Ly-box2_max)/N1:Ly];
fz=[0:l2:N4*l2 (N4*l2+l1):l1:N4*l2+l1*N3 (N4*l2+l1*N3+l3) (N4*l2+l1*N3+l3+l4) (N4*l2+l1*N3+l3+l4+l6) (N4*l2+l1*N3+l3+l4+l6+l7) sum([l8 l7 l6 l4 l3])+ N3*l1 + N4*l2];
fz=0.3048*fz;
end


