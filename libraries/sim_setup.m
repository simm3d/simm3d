function G = sim_setup(Flag,chuteinicial,tol,maxit,Runcode,optke,Ta,symmetric)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

G.setup.Flag=Flag;
                       % Type of sover Flag=1: (A\B)
                       %               Flag=2: pcg
                               
G.setup.chuteinicial=chuteinicial;   % Cute inicial 0(não)/ 1(sim)
G.setup.tol=tol;                     % Tolerância
G.setup.maxit=maxit;                 % Maximum iteration          
G.setup.Runcode=Runcode;             % Runcode=0 >> run with the solver
                                     % Runcode=1 >> run without the solver 
G.setup.optke=optke;                % opts.Ke=1 >> sem mex
                                     % opts.Ke=2 >> com mex
                                     % opts.Ke=3 >> implicita
                                     % opts.Ke=4 >> triplets
                                     % opts.Ke=5 >> triplets com mex
G.setup.Ta=Ta;                       % Ta=1 for sparse,
                                     % Ta=2 for sparse2
                                     % Ta=3 for fparse 
                                     % Ta=4 for sparse_create                               
G.setup.symmetric =symmetric;        % cria uma matriz simétrica (1) ou geral (0)
                                                 
end

