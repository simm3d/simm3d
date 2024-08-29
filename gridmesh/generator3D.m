function G=generator3D(ltype,fx,fy,fz,simbox)
    %   This function generates triangular mesh for a rectangular
    %   shape structure for finite element analysi   
% fx=0:Lx/Nx:Lx;                 % posicao das faces dos blocos na direcao x
% fy=0:Ly/Ny:Ly;                 % posicao das faces dos blocos na direcao y
% fz=0:Lz/Nz:Lz;                 % posicao das faces dos blocos na direcao z
Nx=size(fx,2)-1;
Ny=size(fy,2)-1;
Nz=size(fz,2)-1;

x=repmat(fx,1,(Ny+1)*(Nz+1));
y=repmat(repmat(fy,1,(Nz+1)),(Nx+1),1);
z=repmat(fz,(Nx+1)*(Ny+1),1);
% Gerando coordenadas nodais:
coords=zeros(size(x,2),3);
coords(:,1)=x'; 
coords(:,2)=y(:);
coords(:,3)=z(:);
a1=(Nx+1)*(Ny+1);

z1=repmat(0:Nz-1,Nx*Ny,1);z1=z1(:);
y1=repmat(0:Ny-1,Nx,Nz);y1=y1(:);
x1=repmat(1:Nx,1,Ny*Nz);x1=x1(:);
iy=repmat(1:Ny,Nx,Nz);iy=iy(:);
iz=repmat(1:Nz,Nx*Ny,1);iz=iz(:);
%
 nel=Nx*Ny*Nz;
 k=1:nel;
 % Gerando conectividades HEXAEDROS:
 lnods8=zeros(nel,8,'int32');
 lnods8(k,1)=z1*a1+(Nx+1)*y1+x1;
 lnods8(k,2)=z1*a1+(Nx+1)*y1+x1+ones(nel,1);
 lnods8(k,3)=z1*a1+(Nx+1)*iy+x1+ones(nel,1);
 lnods8(k,4)=z1*a1+(Nx+1)*iy+x1;
 lnods8(k,5)=iz*a1+(Nx+1)*y1+x1;
 lnods8(k,6)=iz*a1+(Nx+1)*y1+x1+ones(nel,1);
 lnods8(k,7)=iz*a1+(Nx+1)*iy+x1+ones(nel,1);
 lnods8(k,8)=iz*a1+(Nx+1)*iy+x1;

% Gerando conectividades TETRAEDROS:
if ltype==1
 i=1:nel;
   lnods(6*(i-1)+1,:)=[lnods8(i,4) lnods8(i,3) lnods8(i,7) lnods8(i,1)];
   lnods(6*(i-1)+2,:)=[lnods8(i,7) lnods8(i,3) lnods8(i,2) lnods8(i,1)];
   lnods(6*(i-1)+3,:)=[lnods8(i,7) lnods8(i,2) lnods8(i,6) lnods8(i,1)];
   lnods(6*(i-1)+4,:)=[lnods8(i,8) lnods8(i,4) lnods8(i,7) lnods8(i,1)];
   lnods(6*(i-1)+5,:)=[lnods8(i,8) lnods8(i,7) lnods8(i,6) lnods8(i,1)];
   lnods(6*(i-1)+6,:)=[lnods8(i,8) lnods8(i,6) lnods8(i,5) lnods8(i,1)];
end
   
%
if ltype==2
    lnods=lnods8;
end
%
if ltype==1
    simc = centroide_Tetra ( coords, lnods );

  [ nel, ~ ] = size ( lnods );
% Definicao dos materiais ( 2: reservatorio; 1:rochas)

mat=ones(nel,1);

imat=find((simc(:,1)>=simbox(1,1) & simc(:,1)<=simbox(1,2) ) & ...
          (simc(:,2)>=simbox(2,1) & simc(:,2)<=simbox(2,2) ) & ...
          (simc(:,3)>=simbox(3,1) & simc(:,3)<=simbox(3,2) ));
mat(imat)=2; 

elseif ltype==2
    simc = centroide_Hexa ( coords, lnods );

  [ nel, ~ ] = size ( lnods );
% Definicao dos materiais ( 2: reservatorio; 1:rochas)

mat=ones(nel,1);

imat=find((simc(:,1)>=simbox(1,1) & simc(:,1)<=simbox(1,2))& ...
          (simc(:,2)>=simbox(2,1) & simc(:,2)<=simbox(2,2)) & ...
          (simc(:,3)<=simbox(3,1) & simc(:,3)>=simbox(3,2)));
mat(imat)=2; 
    
end
%
nn=size(coords,1);
nel=size(lnods,1);
G.elements = struct('nelem'     ,  nel,     'lnods',lnods,                   ...
                    'imat', mat, 'centroid',simc);

G.nodes = struct('num', nn, 'coords', coords);
end

%  #1. Name of function: centroide_Tetra 
function c = centroide_Tetra ( coords, lnods )

%**********************************************************************
%
% Calcular os centroide dos elementos hexaedricos 
%
%  Modificado:
%
%    10 de julho de 2018
%
%  Author:
%
%    Jean B Joseph
%
%  Dados:
%
%    Entradas, coords(nn,3), as coordenadas dos nos
%
%              lnods(nel,8), conectividades dos dos elementos tetraedricos
%
%    Saidas    c(nel,3), As coordenadas dos centros de gravidades
%
%   coords=coords(:,2:4);
%   lnods=lnods(:,2:5);
%   [ nn, ~ ] = size ( coords );

  [ nel, ~ ] = size ( lnods );

  c = zeros ( nel, 3 );

  c(1:nel,1) = ( coords(lnods(1:nel,1),1) + coords(lnods(1:nel,2),1) + ...
                 coords(lnods(1:nel,3),1) + coords(lnods(1:nel,4),1))/ 4.0;
             
  c(1:nel,2) = ( coords(lnods(1:nel,1),2) + coords(lnods(1:nel,2),2) + ...
                 coords(lnods(1:nel,3),2) + coords(lnods(1:nel,4),2))/ 4.0;
             
  c(1:nel,3) = ( coords(lnods(1:nel,1),3) + coords(lnods(1:nel,2),3) + ...
                 coords(lnods(1:nel,3),3) + coords(lnods(1:nel,4),3))/ 4.0;
   end
%  #3. Name of function: centroide_Tetra 
function c = centroide_Hexa( coords, lnods )

%**********************************************************************
%
% Calcular os centroide dos elementos hexaedricos 
%
%  Modificado:
%
%    10 de julho de 2018
%
%  Author:
%
%    Jean B Joseph
%
%  Dados:
%
%    Entradas, coords(nn,3), as coordenadas dos nos
%
%              lnods(nel,8), conectividades dos dos elementos hexaedricos
%
%    Saidas    c(nel,3), As coordenadas dos centros de gravidades
%
%   [ nn, ~ ] = size ( coords );

  [ nel, ~ ] = size ( lnods );

  c = zeros ( nel, 3 );

  c(1:nel,1) = ( coords(lnods(1:nel,1),1) + coords(lnods(1:nel,2),1) + ...
                 coords(lnods(1:nel,3),1) + coords(lnods(1:nel,4),1) + ...
                 coords(lnods(1:nel,5),1) + coords(lnods(1:nel,6),1) + ...
                 coords(lnods(1:nel,7),1) + coords(lnods(1:nel,8),1))/ 8.0;
             
  c(1:nel,2) = ( coords(lnods(1:nel,1),2) + coords(lnods(1:nel,2),2) + ...
                 coords(lnods(1:nel,3),2) + coords(lnods(1:nel,4),2) + ...
                 coords(lnods(1:nel,5),2) + coords(lnods(1:nel,6),2) + ...
                 coords(lnods(1:nel,7),2) + coords(lnods(1:nel,8),2))/ 8.0;
             
  c(1:nel,3) = ( coords(lnods(1:nel,1),3) + coords(lnods(1:nel,2),3) + ...
                 coords(lnods(1:nel,3),3) + coords(lnods(1:nel,4),3) + ...
                 coords(lnods(1:nel,5),3) + coords(lnods(1:nel,6),3) + ...
                 coords(lnods(1:nel,7),3) + coords(lnods(1:nel,8),3))/ 8.0;
   end
