function [E,nu] = elast_mat(G,varargin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%% Materials
mat1=find(G.elements.imat==1);     % Rock region
mat2=find(G.elements.imat==2);     % Reservoir region
%%
if nargin <3 
    error(' Deve entrar pelo menos 3 parametros na função elast_mat')
elseif nargin <4
    E1=varargin{2};
    E2=E1;
elseif nargin==4
    E1=varargin{2};
    E2=varargin{3};
end
E1=varargin{2};
E=zeros(G.elements.nelem,1);        
E(mat1)=E1;          % Young modulus of the rock
E(mat2)=E2;          % Young modulus of the reservoir
nu=varargin{1};      % poisson's ratio
end

