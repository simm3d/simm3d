function G = simgrid(ldim,varargin)
%SIMGRID Constroi malhas 3D
%% SYNOPSIS:
%   G = simgrid(ldim,simbox)
%   G = simgrid(ldim, ndiv,simbox);
%   G = simgrid(ldim, ndiv,ElemType,simbox);
%   G = simgrid(lx,ly,lz,simbox);
%   G = simgrid(lx,ly,lz,ElemType,simbox);
%InputS
%   ldim      >>  Vetor com os comprimentos nas direções x,y e z   >>  
%                 node coordinates in the z direction
%   simbox    >>  Região do reservatório, se não houver reservatório
%                 box=[0 0; 0 0; 0 0]
%   ElemType  >>  Elemtype=1 for tetrahedral mesh,Elemtype=1 for 
%                 hexahedral mesh, Default value FALSE. 
%   lx, Ly e lz   vetor de nós nas direções x,y e z respetivamente
%
%Outputs
%      G - Estrutura de malhas  com as seguintes campo.
%         - G.elements.lnods
%         - G.elements.nelem
%         - G.elements.imat
%         - G.elements.centroid
%
%         - G.nodes.num
%         - G.nodes.coords
%  

if     nargin ==2
       ElemType=1;
       Elemdim = [1 1 1];
       ndim=numel(ldim);
       lx=0:ldim(1):ldim(1);
       ly=0:ldim(2):ldim(2);
       lz=0:ldim(3):ldim(3);
       simbox=varargin{1};
elseif nargin ==3
            if ~all(varargin{1} > 0)
            error('elemgrid deve ser positivo');
            end
       ElemType=1;
       Elemdim = varargin{1};
       ndim=numel(ldim);
       lx=0:ldim(1)/Elemdim(1):ldim(1);
       ly=0:ldim(2)/Elemdim(2):ldim(2);
       lz=0:ldim(3)/Elemdim(2):ldim(3);
       simbox=varargin{2};
elseif nargin==4 && length(varargin{2})==1
%             if ~all(varargin{1} > 0)
%             error('elemgrid deve ser positivo');
%             end     
       ElemType=varargin{2};
       Elemdim =varargin{1};
       lx=0:ldim(1)/Elemdim(1):ldim(1);
       ly=0:ldim(2)/Elemdim(2):ldim(2);
       lz=0:ldim(3)/Elemdim(2):ldim(3);
       ndim=numel(ldim);
       simbox=varargin{3};
elseif nargin==4 && length(varargin{2})~=1
       ElemType=1;
       lx=ldim; ly=varargin{1};lz=varargin{2};
       ndim=3;
       simbox=varargin{3};
elseif nargin==5 
       ElemType=varargin{3};
       lx=ldim; ly=varargin{1};lz=varargin{2};
       ndim=3;
       simbox=varargin{4};
end


switch ndim
    case 3
        G = generator3D(ElemType,lx,ly,lz,simbox);
    otherwise
        error('Não podemos criar malha com %d D: apenas 3 is valid.', ndim);
end

end



