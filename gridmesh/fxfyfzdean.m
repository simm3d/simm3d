function [fx, fy, fz] = fxfyfzdean(N1,N2,N3,N4,box1_min,box1_max,box2_min,box2_max,l1,l2,l3,l4,l6,l7,l8,Lx,Ly)
fx=[0:box1_min /N1:box1_min  (box1_min +(box1_max-box1_min )/N2):(box1_max-box1_min )/N2:box1_max (box1_max+(Lx-box1_max)/N1):(Lx-box1_max)/N1:Lx];
fy=[0:box2_min /N1:box2_min  (box2_min +(box2_max-box2_min )/N2):(box2_max-box2_min )/N2:box2_max (box2_max+(Ly-box2_max)/N1):(Ly-box2_max)/N1:Ly];
fz=[0:l2:N4*l2 (N4*l2+l1):l1:N4*l2+l1*N3 (N4*l2+l1*N3+l3) (N4*l2+l1*N3+l3+l4) (N4*l2+l1*N3+l3+l4+l6) (N4*l2+l1*N3+l3+l4+l6+l7) sum([l8 l7 l6 l4 l3])+ N3*l1 + N4*l2];
fz=0.3048*fz;
end
