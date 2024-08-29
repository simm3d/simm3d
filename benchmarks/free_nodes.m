function [freenodes,fix_u]=free_nodes(coord)
%FREE_NODES Returns the degrees of freedom for free nodes
%  freenodes=FREE_NODES(coord)
%
%Input
%  coord >> coordinate matrix
%Output
%  freenodes >> degrees of freedom vector
[nn,ndim]=size(coord);

% Left and right side in x direction
RLXmin=find(coord(:,1)==min(coord(:,1)));
RLXmax=find(coord(:,1)==max(coord(:,1)));  

% Left and right side in y direction   
RLYmin=find(coord(:,2)==min(coord(:,2)));
RLYmax=find(coord(:,2)==max(coord(:,2)));
% Bottom   
BO= find(coord(:,3)==min(coord(:,3))); 

% Corner lines
cb1=find(coord(:,1) == min(coord(:,1)) & coord(:,2)...
                    == min(coord(:,2)));
cb2=find(coord(:,1) == max(coord(:,1)) & coord(:,2)...
                       == min(coord(:,2)));
cb3=find(coord(:,1) == min(coord(:,1)) & coord(:,2)...
                       == max(coord(:,2)));
cb4=find(coord(:,1) == max(coord(:,1)) & coord(:,2)...
                    == max(coord(:,2)));

% corner and bottom nodes
nt1=find(coord(:,1) == min(coord(:,1)) & coord(:,2)...
                    == min(coord(:,2)) & coord(:,3)...
                    == min(coord(:,3)));
nt2=find(coord(:,1) == max(coord(:,1)) & coord(:,2)...
                    == min(coord(:,2)) & coord(:,3)...
                    == min(coord(:,3)));
nt3=find(coord(:,1) == min(coord(:,1)) & coord(:,2)...
                    == max(coord(:,2)) & coord(:,3)...
                    == min(coord(:,3)));
nt4=find(coord(:,1) == max(coord(:,1)) & coord(:,2)...
                    == max(coord(:,2)) & coord(:,3)...
                    == min(coord(:,3)));
                       
cb=[cb1; cb2; cb3; cb4];
    % lateral nodes in the x and y directions
    rlx=[RLXmin; RLXmax];
    rly=[RLYmin; RLYmax];
    
    % Bottom corner nodes
    ntt=[nt1; nt2; nt3; nt4];
    %
    rx=ndim*rlx - (ndim-1)*ones(size(rlx,1),1);
    ry=ndim*rly - (ndim-2)*ones(size(rly,1),1);
    
    BB=ndim*BO - (ndim-3)*ones(size(BO,1),1);
   
    b1=ndim*cb - (ndim-1)*ones(size(cb,1),1);
    b2=ndim*cb - (ndim-2)*ones(size(cb,1),1);
    
    ntxyz1=ndim*ntt - (ndim-1)*ones(size(ntt,1),1);
    ntxyz2=ndim*ntt - (ndim-2)*ones(size(ntt,1),1);
    ntxyz3=ndim*ntt - (ndim-3)*ones(size(ntt,1),1);
    
    fix_u=unique(sort([b1;b2;rx;ry;ntxyz1;ntxyz2;ntxyz3;BB]));
    freenodes=setdiff(1:ndim*nn,fix_u);                       
end