function [KG,V]=setup_boundary(conf,constnodes,freenodes,KG)

nconst=length(constnodes); nfree=length(freenodes);
ngl=size(KG,1);
if conf.setup.Flag<7    
    KG(constnodes,constnodes)=KG(constnodes,constnodes)+speye(nconst)*1e15;%diag(diag(KG(constnodes,constnodes)))*1e10;
    [~,~,V]=find(KG);
elseif conf.setup.Flag==7
disp('------------------------------------------------------------------')
disp('Esta opção precisa placa de video: GPU ')
disp('------------------------------------------------------------------')
    KG=KG+sparse(constnodes,constnodes,ones(nconst,1),ngl,ngl)*1e15;
    [~,~,V]=find(KG);
    KG=gpuArray(KG);
elseif conf.setup.Flag==7<0 || conf.setup>7
    error('Flag não pode ser negativo ou maior que 7');
end