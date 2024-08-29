function sol = Solver_Type(KG,F,ngl,freenodes,chute,conf)
    tol= conf.setup.tol; maxit= conf.setup.maxit; 
    if conf.setup.Flag==1
            sol=zeros(ngl,1);
            sol(freenodes)=KG(freenodes,freenodes)\F(freenodes);
        elseif conf.setup.Flag==2
            sol=zeros(ngl,1);
            sol(freenodes)= pcg(KG(freenodes,freenodes),F(freenodes),tol,maxit,[],[],chute(freenodes));
        
        elseif conf.setup.Flag<1 || conf.setup.Flag>2

        error('Verifique o valor digitado do Flag na Configuração');
    end
    
end

