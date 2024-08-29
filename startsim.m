function startsim
%Instalar os arquivos do SIMM no diretorio do MATLAB.
 clc
 d = fileparts(mfilename('fullpath'));
 addpath(genpath(d))
 %%
  fprintf(['Bem vindo para o Simulador Inteligente e Modelagem 3D utilizando!',...
      '\nMATLAB(SIMM). Você está utilizando a versão 2020a. Para saber \n']);
  fprintf('mais do nosso grupo visite nosso site ');
  %%
  desk= usejava('desktop');
  link_site='www.lmcg.ufpe.br';    
  nome_link='LMCG';
  mostrar_tela(desk,nome_link,link_site)
  fprintf('\n');
 %%
    fprintf('  Alguns exemplos para iniciar:\n');
    fprintf(['  1. Viga engastada e Livre                     :>> ',...
             '<a href="matlab: viga_eng_3D"> Rodar aqui</a>\n']);
    fprintf(['  2. Viga engastada e Livre sem teste de memoria:>> ',...
             '<a href="matlab: viga_eng_3D_v2"> Rodar aqui</a>\n']);
    fprintf(['  3. Problema do Dean et al                     :>> ',...
             '<a href="matlab: dean_2006"> Rodar aqui</a>\n'])  ;
    
end




