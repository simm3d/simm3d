function[L,C,V,aux]= Elast3DT4_Ke(G,conf,E,nu)
%ELAST3DT4 Summary of this function goes here
%   Detailed explanation goes here
%% Local stiffness matrix of all elements [Ke]
%
% Matrix Ke (complete matrix)
GL=montar_GL(G.elements.lnods);

if conf.setup.symmetric ==0

    if conf.setup.optke==1
        GL=permute(GL,[3 2 1]);   % GL in 3D Matrix
        % vector with lines in the global matrix (indices)
        aux=repmat(GL,1,12,1);
        L=aux(:);
        % vector with columns in the global matrix (indices)
        aux=repmat(GL,12,1,1);
        C=aux(:);
        % vector with values in the global matrix (values)
         Ke=rigidez_explicita2(nu,E,G.nodes.coords,G.elements.lnods);
         aux=Ke;
         V=aux(:);
     elseif conf.setup.optke==2
        disp('-----------------------------------------------------------')
        disp([' Good job, Ke was built implicitly'])
        disp('-----------------------------------------------------------')
        GL=permute(GL,[3 2 1]);   % GL in 3D Matrix
        % vector with lines in the global matrix (indices)
        aux=repmat(GL,1,12,1);
        L=aux(:);
        % vector with columns in the global matrix (indices)
        aux=repmat(GL,12,1,1);
        C=aux(:);
        % vector with values in the global matrix (values)
        Ke= Ke_t4_v0(G.nodes.coords,G.elements.lnods,E,nu);     
        V=Ke(:);
        aux=reshape(Ke,144,G.elements.nelem);
    elseif conf.setup.optke==3
          coord=[(1:G.nodes.num)' G.nodes.coords];
          conec=[(1:G.elements.nelem)' G.elements.lnods];
          [L,C,V] = triplets_tetra(coord,conec,E,nu); 
          aux=[];
    elseif conf.setup.optke==4  
          E1=E(1);
          coord=[(1:G.nodes.num)' G.nodes.coords];
          conec=double([(1:G.elements.nelem)' G.elements.lnods]);
          [L,C,V] = triplets_tetra_mex(coord,conec,E1,nu); 
          aux=[];
    end
    
elseif conf.setup.symmetric ==1
       
       
disp('-------------------------------------------------------------------')
disp('symmetric sparse, common element matrix for all elements')
disp('-------------------------------------------------------------------')
    
     if conf.setup.optke==1
% vector with lines in the global matrix (indices)
aux=GL(:,[1:12 2:12 3:12 4:12 5:12 6:12 7:12 8:12 9:12 10:12 11:12 12])';
L=aux(:);

% vector with columns in the global matrix (indices)
aux=GL(:,[1*ones(1,12) 2*ones(1,11) 3*ones(1,10) 4*ones(1,9) 5*ones(1,8)...
           6*ones(1,7) 7*ones(1,6) 8*ones(1,5) 9*ones(1,4) 10*ones(1,3) ...
            11*ones(1,2)  12])';
C=aux(:);
        % vector with values in the global matrix (values)
%         Ke=rigidez_explicita2(nu,E,G.nodes.coords,G.elements.lnods);
        [Ke,~]=rigidez_explicita2sim(nu,E,G);
        aux=Ke';
%         aux=Ke([1:12 14:24 27:36 40:48 53:60 66:72 79:84 92:96 105:108 118:120 131:132 144 ],:);
        V=aux(:);
     elseif conf.setup.optke==2
        disp('-----------------------------------------------------------')
        disp([' Good job, Ke was built implicitly'])
        disp('-----------------------------------------------------------')
% vector with lines in the global matrix (indices)
aux=GL(:,[1:12 2:12 3:12 4:12 5:12 6:12 7:12 8:12 9:12 10:12 11:12 12])';
        L=aux(:);

% vector with columns in the global matrix (indices)
aux=GL(:,[1*ones(1,12) 2*ones(1,11) 3*ones(1,10) 4*ones(1,9) 5*ones(1,8)...
           6*ones(1,7) 7*ones(1,6) 8*ones(1,5) 9*ones(1,4) 10*ones(1,3) ...
            11*ones(1,2)  12])';
        C=aux(:);
        % vector with values in the global matrix (values)
        Ke= Ke_t4_v0(G.nodes.coords,G.elements.lnods,E,nu);  
        aux=Ke(:,[1:12 14:24 27:36 40:48 53:60 66:72 79:84 92:96 105:108 118:120 131:132 144 ],:);
        aux=reshape(aux,78,[]);
        V=aux(:);             
    elseif conf.setup.optke==3
          coord=[(1:G.nodes.num)' G.nodes.coords];
          conec=[(1:G.elements.nelem)' G.elements.lnods];
          [L,C,V] = triplets_tetra(coord,conec,E,nu);
          aux=[];
    elseif conf.setup.opke==4  
          coord=[(1:G.nodes.num)' G.nodes.coords];
          conec=[(1:G.elements.nelem)' G.elements.lnods];
          [L,C,V] = triplets_tetra_mex(coord,conec,E,nu);  
          aux=[];
    end  
end
end
function GL=montar_GL(conec)
GL=[3*conec(:,1)-2 3*conec(:,1)-1 3*conec(:,1) ...
    3*conec(:,2)-2 3*conec(:,2)-1 3*conec(:,2) ...
    3*conec(:,3)-2 3*conec(:,3)-1 3*conec(:,3) ...
    3*conec(:,4)-2 3*conec(:,4)-1 3*conec(:,4)];
end

