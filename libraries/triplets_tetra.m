function [L,C,V] = triplets_tetra(coord,conec,E,v)

%   Calcula os triplets para uma discretização com tetraedos lineares
%   L = posições globais nas linhas
%   C = posições globais nas colunas
%   V = valores

% nota: assume coord com dimensões nn x 4
% nota2: assume conec com dimensões nel x 5

nel=length(conec);

L=zeros(144,nel);    % 144 posições do tetraedro linear
C=zeros(144,nel);
V=zeros(144,nel);

%matriz constitutiva D
D =  E(1)/((1+v)*(1-2*v))*[1-v v v 0 0 0;
                        v 1-v v 0 0 0;
                        v v 1-v 0 0 0;
                        0 0 0 (1-2*v)/2 0 0;
                        0 0 0 0 (1-2*v)/2 0;
                        0 0 0 0 0 (1-2*v)/2];

for i=1:nel     % loop ao longo dos elementos

   % nós dos elementos
   no1=conec(i,2);  no2=conec(i,3);   no3=conec(i,4);  no4=conec(i,5);
   % coordenadas nodais
   x1=coord(no1,2); y1=coord(no1,3); z1=coord(no1,4);
   x2=coord(no2,2); y2=coord(no2,3); z2=coord(no2,4);
   x3=coord(no3,2); y3=coord(no3,3); z3=coord(no3,4);
   x4=coord(no4,2); y4=coord(no4,3); z4=coord(no4,4);
       
   % volume do elemento
   vol=(1/6)* abs(det([1 x1 y1 z1;
                        1 x2 y2 z2;
                        1 x3 y3 z3;
                        1 x4 y4 z4]));
  % parâmetro auxiliar
  detA=6*vol;

  % Cooeficiente da função de forma ( quatro nos)    
   b1=-det([1 1 1; y2 y3 y4; z2 z3 z4]');
   c1=det([1 1 1; x2 x3 x4; z2 z3 z4]');
   d1=-det([1 1 1; x2 x3 x4; y2 y3 y4]');
   
   b2=det([1 1 1; y1 y3 y4; z1 z3 z4 ]');
   c2=-det([1 1 1; x1 x3 x4; z1 z3 z4]');
   d2=det([1 1 1; x1 x3 x4; y1 y3 y4]');
   
   b3=-det([1 1 1; y1 y2 y4; z1 z2 z4 ]');
   c3=det([1 1 1; x1 x2 x4; z1 z2 z4]');
   d3=-det([1 1 1; x1 x2 x4; y1 y2 y4]');
   
   b4=det([1 1 1; y1 y2 y3; z1 z2 z3 ]');
   c4=-det([1 1 1; x1 x2 x3; z1 z2 z3]');
   d4=det([1 1 1; x1 x2 x3; y1 y2 y3]');

  % Gradiente das funções de forma N1, N2, N3 e N4 
  GN1=(1/detA)*[b1 0  0  ;
                0  c1 0  ;
                0  0  d1 ;
                c1 b1 0  ;
                0  d1 c1 ;
                d1 0  b1];
            
  GN2=(1/detA)*[b2 0  0  ;
                0  c2 0  ;
                0  0  d2 ;
                c2 b2 0  ;
                0  d2 c2 ;
                d2 0  b2];
            
  GN3=(1/detA)*[b3 0  0  ;
                0  c3 0  ;
                0  0  d3 ;
                c3 b3 0  ;
                0  d3 c3 ;
                d3 0  b3];
            
  GN4=(1/detA)*[b4 0  0  ;
                0  c4 0  ;
                0  0  d4 ;
                c4 b4 0  ;
                0  d4 c4 ;
                d4 0  b4];
   % matriz B
   B=[ GN1 GN2 GN3 GN4];

   % Matriz de rigidez do elemento
   Ke=B'*D*B*vol;
   
   % valores referentes ao elemento
   valor=Ke(:);
 
 % graus de liberdade
 gl=[3*no1-2 3*no1-1 3*no1 3*no2-2 3*no2-1 3*no2 3*no3-2 3*no3-1 3*no3 3*no4-2 3*no4-1 3*no4];
 aux1=1:12;
 aux2=repmat(aux1,12,1);
 ii=aux2(:);
 jj=aux2';
 jj=jj(:); 
 
 % linhas e colunas referentes ao elemento
 linha = gl(ii);   
 coluna = gl(jj);

 % acumula os triplets em cada coluna, para cada elemento
 L(:,i)=linha;
 C(:,i)=coluna;
 V(:,i)=valor;
 
end

end

