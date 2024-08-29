function [freenodes,constnodes]=free_nodes_viga(coord)
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
    % lateral nodes in the x and y directions
    rlx=RLXmin;
    rx1=ndim*rlx - (ndim-1)*ones(size(rlx,1),1);
    rx2=ndim*rlx - (ndim-2)*ones(size(rlx,1),1);
    rx3=ndim*rlx - (ndim-3)*ones(size(rlx,1),1);
    
    fix_u=unique(sort([rx1;rx2;rx3]));
    freenodes =(setdiff(1:ndim*nn,fix_u))';                       
    constnodes=(find(ismember(1:nn*ndim,freenodes)==0))';
end