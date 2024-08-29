function F = dF(conf,P0,Pn,G)
%%
alpha=zeros(1,1,G.elements.nelem);     % initialization of Biot coefficients 
%
alpha(:,:,find(G.elements.imat==1))=0; % Biot coefficients for capping rocks    
alpha(:,:,find(G.elements.imat==2))=1; % Biot coefficients for the reservoir
%
coord=G.nodes.coords;
lnods=G.elements.lnods;
%
nn=size(coord,1);
nel=size(lnods,1);
dppressure=zeros(1,6,nel);
[X1,X2,X3,X4,Y1,Y2,Y3,Y4,Z1,Z2,Z3,Z4]=XYZ(coord,lnods);
%
B = BT4_matrix(coord,lnods);
%
GL=permute([3*lnods(:,1)-2 3*lnods(:,1)-1 3*lnods(:,1) ...
    3*lnods(:,2)-2 3*lnods(:,2)-1 3*lnods(:,2) ...
    3*lnods(:,3)-2 3*lnods(:,3)-1 3*lnods(:,3) ...
    3*lnods(:,4)-2 3*lnods(:,4)-1 3*lnods(:,4)]',[ 3 1 2]);
%
[VV]=volume_tetra(X1,X2,X3,X4,Y1,Y2,Y3,Y4,Z1,Z2,Z3,Z4);
Ve=permute(VV', [3 1 2]);  
% Dimension global matrix and vector of hydraulic problem
ngl=nn*3;                
%
LNODS3D=permute(reshape(lnods', 1,4,[]),[2 1 3]);
%
dp= squeeze(mean(P0(LNODS3D))-mean(Pn(LNODS3D))); 
%
clear LNODS3D
     dppressure(1,1:3,:)=mtimesx(alpha,permute([dp dp dp],[3 2 1]));
     Few1=-mtimesx(B,'T',dppressure,'T');
     Few = mtimesx(Few1,Ve);
     linhaf=GL(:);
     FFw=Few(:);
     clear Few Few1 B
     if conf.setup.Ta==1
     F=sparse(double(linhaf),1,FFw,ngl,1); 
     elseif conf.setup.Ta==2
     F=sparse2(linhaf,1,FFw,ngl,1); 
     elseif conf.setup.Ta==3
     F=fsparse(linhaf,1,FFw,ngl); 
     elseif conf.setup.Ta==4
     F=sparse(double(linhaf),1,FFw,ngl,1); 
     %
     end
         
end
%%
function B = BT4_matrix(coord,conec)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%
[X1,X2,X3,X4,Y1,Y2,Y3,Y4,Z1,Z2,Z3,Z4]=XYZ(coord,conec);
%
VV=volume_tetra(X1,X2,X3,X4,Y1,Y2,Y3,Y4,Z1,Z2,Z3,Z4);
%
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
%%
vol=VV;
B=zeros(6,12,size(conec,1));
aux1=1./(6*vol);
% 1a linha
B(1,1,:)=aux1.*b1;
B(1,2,:)=0;
B(1,3,:)=0;
B(1,4,:)=aux1.*b2;
B(1,5,:)=0;
B(1,6,:)=0;
B(1,7,:)=aux1.*b3;
B(1,8,:)=0;
B(1,9,:)=0;
B(1,10,:)=aux1.*b4;
B(1,11,:)=0;
B(1,12,:)=0;
% 2a linha
B(2,1,:)=0;
B(2,2,:)=aux1.*c1;
B(2,3,:)=0;
B(2,4,:)=0;
B(2,5,:)=aux1.*c2;
B(2,6,:)=0;
B(2,7,:)=0;
B(2,8,:)=aux1.*c3;
B(2,9,:)=0;
B(2,10,:)=0;
B(2,11,:)=aux1.*c4;
B(2,12,:)=0;

% 3a linha
B(3,1,:)=0;
B(3,2,:)=0;
B(3,3,:)=aux1.*d1;
B(3,4,:)=0;
B(3,5,:)=0;
B(3,6,:)=aux1.*d2;
B(3,7,:)=0;
B(3,8,:)=0;
B(3,9,:)=aux1.*d3;
B(3,10,:)=0;
B(3,11,:)=0;
B(3,12,:)=aux1.*d4;

% 4a linha
B(4,1,:)=aux1.*c1;
B(4,2,:)=aux1.*b1;
B(4,3,:)=0;
B(4,4,:)=aux1.*c2;
B(4,5,:)=aux1.*b2;
B(4,6,:)=0;
B(4,7,:)=aux1.*c3;
B(4,8,:)=aux1.*b3;
B(4,9,:)=0;
B(4,10,:)=aux1.*c4;
B(4,11,:)=aux1.*b4;
B(4,12,:)=0;
%5a linha 
B(5,1,:)=0;
B(5,2,:)=aux1.*d1;
B(5,3,:)=aux1.*c1;
B(5,4,:)=0;
B(5,5,:)=aux1.*d2;
B(5,6,:)=aux1.*c2;
B(5,7,:)=0;
B(5,8,:)=aux1.*d3;
B(5,9,:)=aux1.*c3;
B(5,10,:)=0;
B(5,11,:)=aux1.*d4;
B(5,12,:)=aux1.*c4;

%6a linha 
B(6,1,:)=aux1.*d1;
B(6,2,:)=0;
B(6,3,:)=aux1.*b1;
B(6,4,:)=aux1.*d2;
B(6,5,:)=0;
B(6,6,:)=aux1.*b2;
B(6,7,:)=aux1.*d3;
B(6,8,:)=0;
B(6,9,:)=aux1.*b3;
B(6,10,:)=aux1.*d4;
B(6,11,:)=0;
B(6,12,:)=aux1.*b4;
end

function [X1,X2,X3,X4,Y1,Y2,Y3,Y4,Z1,Z2,Z3,Z4]=XYZ(coord,conec)
X1=coord(conec(:,1),1); Y1=coord(conec(:,1),2); Z1=coord(conec(:,1),3);
X2=coord(conec(:,2),1); Y2=coord(conec(:,2),2); Z2=coord(conec(:,2),3);
X3=coord(conec(:,3),1); Y3=coord(conec(:,3),2); Z3=coord(conec(:,3),3);
X4=coord(conec(:,4),1); Y4=coord(conec(:,4),2); Z4=coord(conec(:,4),3);
end
%
function [VV]=volume_tetra(X1,X2,X3,X4,Y1,Y2,Y3,Y4,Z1,Z2,Z3,Z4)

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

