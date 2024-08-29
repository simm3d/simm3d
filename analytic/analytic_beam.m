function displ = analytic_beam(L,P,E)
%ANALYTIC_BEAM calcula o deslocamento máximo para uma viga engastada e
%livre submetido a um carregamento pontual
% Entradas
%    L: comprimento da viga em metro
%    P: Carga pontual em Newton 
%    E: Modulo de elasticidade
% Saída
%    displ: Deslocamento em metro
format bank
I=L(2)*L(3)^3/12;
displ=P*L(1)^3/(3*E*I);
end

