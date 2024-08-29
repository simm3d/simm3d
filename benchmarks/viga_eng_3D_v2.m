%Esse exemplo ensina o passo a passo para calcular o 
%deslocamento máximo de uma viga engastaga livre 3D com uma carga pontual
%na sua extremidade extrema.
%
%{
Neste vamos ensinar o passo a passo para calcular o deslocamento máximo de
uma viga engastaga livre 3D com uma carga pontual na sua extremidade 
extrema.

1. A viga tem um comprimento de 10 metros e uma seção quadrada de 1x1 m2
2. A viga tem um modulo de elasticidade de E=1e10 Pa e um coeficiente de
poisson nu=0.30;
% A Gera a malha dos elementos finitos

L=[10,1,1];              % Comprimentos [lx, ly, lz];
N=[10,2,2];              % Divisões [nx,ny,nz];
simbox=zeros(3,2);       % delimitação da região 2 simbox=[0 0;0 0; 0 0]
                         % simbox nulo significa que temos apenas uma
                         % região na modelagem
fx=0:L(1)/N(1):L(1);
fy=0:L(2)/N(2):L(2);
fz=0:L(3)/N(3):L(3);
%% gerador da malha
G = simgrid(fx,fy,fz,simbox); 

%% Configuração do problema veja o manual: libraries >> sim_setup

%% Materiais

%}

%clc; 
clear
[user1, sys1] = memory; % de lugar no início do seu programa
memory_tol=0;
ii=1;
memo_usado=memory_tol;

%% A.GERAR A MALHA
tic
% Mesh grid length in feet
L=[10,1,1];
N=ii*[40,4,4];
simbox=zeros(3,2);
fx=0:L(1)/N(1):L(1);
fy=0:L(2)/N(2):L(2);
fz=0:L(3)/N(3):L(3);
T.time_grid=toc;  
%% gerar a malha
tic
G = simgrid(fx,fy,fz,simbox); 
T.time_mesh=toc;
%% B. CONFIGURAÇÃO
tic
Flag=1;                        % Type of sover Flag=2: pcg; 
chuteinicial=1;                % Cute inicial 0(não)/ 1(sim)
tol=1e-04;                     % Tolerância
maxit=1000;                    % Maximum iteration                           
Runcode=1;                     % Runcode=0 >> run with the solver
optke=4;                       % opts.Ke=1 >> sem mex
Ta=3;                          % Ta=1 for sparse,                              
symmetric =0;                  % cria uma matriz simétrica (1) ou geral (0)
                               % não entendi ainda o funcionamento                        
conf = sim_setup(Flag,chuteinicial,tol,maxit,Runcode,optke,Ta,symmetric);
T.time_setup=toc;
%
disp('------------------------------------------------------------------')
disp(['PROBLEMA #: ', num2str(ii)])
disp('------------------------------------------------------------------')
disp('------------------------------------------------------------------')
disp(['Numero de elementos            : ', num2str(G.elements.nelem)])
disp('------------------------------------------------------------------')
disp(['Numero de graus de liberdade   : ', num2str(G.nodes.num*3)])
disp('------------------------------------------------------------------')
disp('------------------------------------------------------------------')
disp(['Memoria utilizada em GB        : ', num2str(memo_usado)])
disp('------------------------------------------------------------------')

%% C. MATERIAIS
tic
E1=1e10;
E2=1e10;
nu=0.30;
[E,nu] = elast_mat(G,nu,E1,E2);     
T.time_material=toc;
%% D. CALCULAR Ke
 tic
 [L,C,V,Ke]= Elast3DT4_Ke(G,conf,E,nu); 
 T.time_elast_ke=toc;
%% E. CALCULAR KG
tic
KG = Elast3DT4_KG(L,C,V,Ke,G,conf); 
T.time_elast_KG=toc;
%% F. CONDIÇÕES DE CONTORNO
tic
[freenodes,constnodes]=free_nodes_viga(G.nodes.coords);% nós fixos e livres
nconst=length(constnodes);
T.time_freenodes=toc;
%
tic
[KG,V]=setup_boundary(conf,constnodes,freenodes,KG);    
T.time_elast_bound=toc;
%% G. CARREGAMENTO
tic
ngl=G.nodes.num*3;
nosmoni=find(G.nodes.coords(:,1)== max(G.nodes.coords(:,1))     ...
          & G.nodes.coords(:,2)== max(G.nodes.coords(:,2))*0.5 ...
          & G.nodes.coords(:,3)== max(G.nodes.coords(:,3)));
F=zeros(ngl,1);
F(nosmoni*3)=-1e6;
F(constnodes)=zeros(nconst,1);
T.time_elast_load=toc;
%% H.SOLVER
tic
chute=zeros(ngl,1);
sol= Solver_Type(KG,F,ngl,freenodes,chute,conf);
T.time_sol=toc;
T.temp_media=T.time_sol;
sol_nos=sol(nosmoni*3);


%% RESUMO
% figure
% sim_report(T,conf,'true')
%% PLOTAR DESLOCAMENTO MAXIMO
displ = analytic_beam([10 1 1],-1e06,1e10);
ddispl=(displ-sol_nos)/displ;
disp('-----------------------------------------------------------------')
disp(['Deslocamento na extremidade livre            : ', num2str(sol_nos)])
disp(['Solução analitica                            : ', num2str(displ)])
disp('-----------------------------------------------------------------')
disp(['Error relativo                               : ', num2str(ddispl)])
