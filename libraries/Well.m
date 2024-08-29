function nosmoni=Well(box1_max,box1_min,box2_max,box2_min,Lx,Ly,N2,N3,l1,l2,N4,c,conec)

Xmin=Lx/2-(box1_max-box1_min)/N2/2;
Xmax=Lx/2+(box1_max-box1_min)/N2/2;

Ymin=Ly/2-(box2_max-box2_min)/N2/2;
Ymax=Ly/2+(box2_max-box2_min)/N2/2;

Zmin=ft2m(N4*l2);
Zmax=ft2m(N4*l2+l1*N3);

elemwell=find((c(:,1)>=Xmin   &  c(:,1)<=Xmax)  & ...
              (c(:,2)>=Ymin   &  c(:,2)<=Ymax)  & ...
              (c(:,3)>=Zmin   &  c(:,3)<=Zmax)) ;
          
elemwell=find((c(:,1)>=Xmin   &  c(:,1)<=Xmax)  & ...
              (c(:,2)>=Ymin   &  c(:,2)<=Ymax)  & ...
              (c(:,3)>=Zmin   &  c(:,3)<=Zmax)) ;          
          
nosmoni=conec(elemwell(end),1);  
end

function vm=ft2m(vft)
%FT2M convert feet to meters
%  vm=FT2M(vft)
%
%Input
%  vft >> Value in feet
%Output
%   vm >> Value in meters
vm = 0.3048*vft;
end

