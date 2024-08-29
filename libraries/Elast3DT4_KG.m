function KG = Elast3DT4_KG(L,C,V,Ke,G,conf)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[nn, ndim]=size(G.nodes.coords); ngl=ndim*nn;

        if conf.setup.Ta==1
            L=double(L); C=double(C);
            KG=sparse (L,C,V,ngl,ngl);
        elseif conf.setup.Ta==2
            KG=sparse2(L,C,V,ngl,ngl);
        elseif conf.setup.Ta==3
            KG=fsparse(L,C,V,[ngl ngl]);
        elseif conf.setup.Ta==4
            
            if conf.setup.optke > 2
            error('Optke não pode ser maior que 2 veja sim_setup.m');
            end
               conec=conec_spcreate(G);
               
            if conf.setup.symmetric==0
            KG=sparse_create(conec,Ke);
            elseif conf.setup.symmetric==1
            opts.symmetric=conf.setup.symmetric;    
            KG=sparse_create(conec,Ke,opts);  
            end
    
        end
        
            if conf.setup.symmetric==1 
                diagonal=diag(diag(KG));
                KG=KG+KG'-diagonal;
            end
end

function conecR=conec_spcreate(G)
    
    conec=(G.elements.lnods)';
    conecR=uint32(zeros(12,G.elements.nelem));% matriz que reorganiza GL's

    conecR(1,:)=conec(1,:)*3-2;       % 3*no1-2
    conecR(2,:)=conec(1,:)*3-1;       % 3*no1-1
    conecR(3,:)=conec(1,:)*3-0;       % 3*no1-0

    conecR(4,:)=conec(2,:)*3-2;       % 3*no2-2
    conecR(5,:)=conec(2,:)*3-1;       % 3*no2-1
    conecR(6,:)=conec(2,:)*3-0;       % 3*no2-0

    conecR(7,:)=conec(3,:)*3-2;       % 3*no3-2
    conecR(8,:)=conec(3,:)*3-1;       % 3*no3-1
    conecR(9,:)=conec(3,:)*3-0;       % 3*no3-0

    conecR(10,:)=conec(4,:)*3-2;      % 3*no4-2
    conecR(11,:)=conec(4,:)*3-1;      % 3*no4-1
    conecR(12,:)=conec(4,:)*3-0;      % 3*no4-0

end