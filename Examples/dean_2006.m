%{
Este problema é clássico na indústria de óleo de gás  em que a produção do 
reservatório traz efeitos geomecânica nas rochas adjacentes, efeitos 
conhecidos com subsidência da superfície e a compactação do reservatório, 
o artigo do (Dean et al,2006) estuda muito bem esse problema.

%}
%clc; 
clear
%% A.GERAR A MALHA
tic
% Mesh grid length in feet
 l1 = 50;  l2=100; l3=200; l4=800; l5=1000; l6=2000; l7=3000;  l8=4000;
% Mesh grid
 N1=5;    % Grid number in the x direction of the left and right side rocks
 N2=11;   % Grid number in the x and y direction in the reservoir region
 N3=5;    % Grid number in the z direction in the reservoir region
 N4=2;    % Grid number in the z direction at the bottom of the rock
 N11=5;   % Grid number in the x direction of the left and right side rocks
 N22=11;  % Grid number in the x and y direction in the reservoir region
 
[fx,fy,fz,simbox] = fxfyfz_dean(l1,l2,l3,l4,l5,l6,l7,l8,N1,N2,N3,N4,N11,N22);
T.time_grid=toc;  
disp('------------------------------------------------------------------')
disp(['Time to generate the grid       (s): ', num2str(T.time_grid)])
disp('------------------------------------------------------------------')
%% B. CHAMAR O GERADOR 
tic
G = simgrid(fx,fy,fz,simbox); 
T.time_mesh=toc;
disp('------------------------------------------------------------------')
disp(['Time to generate the mesh       (s): ', num2str(T.time_mesh)])
disp('------------------------------------------------------------------')
%% C. CONFIGURAÇÃO
tic
Flag=2;                        % Type of sover Flag=2: (pcg)
chuteinicial=1;                % Chute inicial 0(não)/ 1(sim)
tol=1e-04;                     % Tolerância
maxit=100;                     % Maximum iteration                           
Runcode=1;                     % Runcode=0 >> run with the solver
optmex=1;                      % opts.Ke=1 >> sem mex
Ta=4;                          % Ta=4 for sparse_create see manual                            
symmetric =1;                  % cria uma matriz simétrica (1) ou geral (0)
                               % não entendi ainda o funcionamento                        
conf = sim_setup(Flag,chuteinicial,tol,maxit,Runcode,optmex,Ta,symmetric);
T.time_setup=toc;
disp('------------------------------------------------------------------')
disp(['Time to configure the problem   (s): ', num2str(T.time_setup)])
disp('------------------------------------------------------------------')
%% D. MATERIAIS
tic
E1=6895;
E2=68.95;
nu=0.30;
[E,nu] = elast_mat(G,nu,E1,E2);   
T.time_material=toc;
disp('-----------------------------------------------------------------')
disp(['Time to setup the materials     (s): ', num2str(T.time_material)])
disp('------------------------------------------------------------------')
%% E. CALCULAR Ke
 tic
 [L,C,V,Ke]= Elast3DT4_Ke(G,conf,E,nu); 
 T.time_elast_ke=toc;
disp('------------------------------------------------------------------')
disp(['Time to calculate Ke            (s): ', num2str(T.time_elast_ke)])
disp('------------------------------------------------------------------')
%% F. CALCULAR KG
tic
KG = Elast3DT4_KG(L,C,V,Ke,G,conf); 
T.time_elast_KG=toc;
disp('------------------------------------------------------------------')
disp(['Time to calculate KG            (s): ', num2str(T.time_elast_KG)])
disp('------------------------------------------------------------------')
%% G. CONDIÇÕES DE CONTORNO
tic
[freenodes,constnodes]=free_nodes(G.nodes.coords);          % freenodes
nconst=length(constnodes);
T.time_freenodes=toc;
disp('------------------------------------------------------------------')
disp(['Time to  find the freenodes     (s): ', num2str(T.time_freenodes)])
disp('------------------------------------------------------------------')
%
tic
[KG,V]=setup_boundary(conf,constnodes,freenodes,KG);
T.time_elast_bound=toc;
disp('------------------------------------------------------------------')
disp(['Time to  fix the nodes          (s): ', num2str(T.time_elast_bound)])
disp('------------------------------------------------------------------')
%% H. CARREGAMENTO
tic
load Pressure0.mat                    % Nodal pressures of the flow problem
P0=Pressure(:,1);                     % hydrostatic pressures
displ=zeros(G.nodes.num*3,1);
ngl=G.nodes.num*3;
ii=1;
c=G.elements.centroid;
conecKe=G.elements.lnods;
box1_min=simbox(1,1);box1_max=simbox(1,2);
box2_min=simbox(2,1);box2_max=simbox(2,2);
Lx=max(fx);
Ly=max(fy);
% Nós do poço
nosmoni=Well(box1_max,box1_min,box2_max,box2_min,Lx,Ly,N2,N3,l1,l2,N4,c,conecKe);
%
chute=zeros(ngl,1);
T.time_elast_load=toc;
%% I. LOOPS DA PRODUÇÃO
tic
for ipressure=1:size(Pressure,2)
    disp(['step=' num2str(ii) '/' num2str(size(Pressure,2))])    
    Pn=Pressure(:,ipressure);    
    F = full(dF(conf,P0,Pn,G));  % Loading due to pressure difference
    F(constnodes)=zeros(nconst,1);
    %
    sol= Solver_Type(KG,F,ngl,freenodes,chute,conf);
    time_solve2=toc;
    displ=sol;
    if chuteinicial==1
        chute=displ;
    end
    sol_nos(ii)=abs(displ(nosmoni*3));  
    % 
    ii=ii+1;
end
T.time_sol=toc;
T.temp_media=T.time_sol/(ii-1);
%% J. RESUMO
figure
sim_report(T,conf,'true')
%% K. PLOTAR DESLOCAMENTO MAXIMO
figure(2)
load tempo.mat 
load dipl_dean.txt 
load tempo_dean.txt
T=T-T(1);
plot(T(1:end-2),sol_nos, tempo_dean,dipl_dean)
%%