clc; clear
clf('reset')
%% O cartao das grelhas
tic
%% Call flowSolverTutorial1.m
flowSolverTutorial1.m
% Mesh grid length in feet
L=[1 1 30];
N=[1,2,30];
simbox=zeros(3,2);
fx=0:L(1)/N(1):L(1);
fy=0:L(2)/N(2):L(2);
fz=0:L(3)/N(3):L(3);
T.time_grid=toc;  
%% gerar a malha
tic
G = simgrid(fx,fy,fz,simbox); 
T.time_mesh=toc;
%% Configuration
tic
Flag=2;                        % Type of sover Flag=1: (A\B)
chuteinicial=1;                % Cute inicial 0(não)/ 1(sim)
tol=1e-04;                     % Tolerância
maxit=10000;                   % Maximum iteration                           
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

%%
tic
Mat = struct('E1'        , 1e10  , ... % Young's modulus of the reservoir
             'E2'        , 1e10 , ...  % Young' modulus of the reservoir
             'nu'        , 0.30  , ... % Poison's ratio
             'islinear'  , true);
[E,nu] = elast_mat(G,Mat);     
T.time_material=toc;
 %%
 tic
 [L,C,V,Ke]= Elast3DT4_Ke(G,conf,E,nu); 
 T.time_elast_ke=toc;
%%
tic
KG = Elast3DT4_KG(L,C,V,Ke,G,conf); 
T.time_elast_KG=toc;


%% Boundary conditions
tic
[freenodes,constnodes]=free_nodes_viga(G.nodes.coords);          % freenodes
nconst=length(constnodes);
T.time_freenodes=toc;
%
tic
[KG,V]=setup_boundary(conf,constnodes,freenodes,KG);
T.time_elast_bound=toc;
%% Load
tic
ngl=G.nodes.num*3;
nosmoni=find(G.nodes.coords(:,1)== max(G.nodes.coords(:,1))     ...
          & G.nodes.coords(:,2)== max(G.nodes.coords(:,2))*0.5 ...
          & G.nodes.coords(:,3)== max(G.nodes.coords(:,3)));
F=zeros(ngl,1);
F(nosmoni*3)=-1e6;
F(constnodes)=zeros(nconst,1);
T.time_elast_load=toc;

%%
tic
chute=zeros(ngl,1);
sol= Solver_Type(KG,F,ngl,freenodes,chute,conf,L,C,V);
T.time_sol=toc;
T.temp_media=T.time_sol;
sol_nos(ii)=sol(nosmoni*3);
%%
figure(1)
sim_report(T,conf)
%%
% figure(3)
% plot(sol_nos)
%%
