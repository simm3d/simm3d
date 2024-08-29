function  sim_report(T,varargin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% subplot(2,2,1)

if nargin==3 && varargin{2}=="true"
    figure(1)
conf=varargin{1};
Part1 = T.time_mesh+T.time_grid+T.time_setup+T.time_material;
Part2 = T. time_elast_ke;
Part3 = T.time_elast_KG;
Part4 = T.time_freenodes+ T.time_elast_bound;
Part5 = T.time_elast_load;
% Part6 = T.temp_media;
Part6 = T.time_sol;
Part = 1000*[Part1 Part2 Part3 Part4 Part5 Part6];
[a,b]=max(Part);
explode = [0 0 0 0 0 0 ];
explode(b)=1;
labels = {'mesh+setup','Ke','KG','Boundary','Load','solver'};
figure(1)
t = tiledlayout(2,2);
ax1 = nexttile;
pie(ax1,Part)
legend(labels)
title('Perfomance')
ax2 = nexttile;
p=pie(ax2,Part,explode);
legend(labels)
t = p(2*b);
t.BackgroundColor = 'cyan';
t.EdgeColor = 'red';
t.FontSize = 14;
title('Parte com maior tempo  destacada')
%%
dim1 = [.1 .2 .25 .15];
dim2 = [.4 .2 .25 .15];
dim3 = [.7 .2 .25 .15];
str1 = 'Stiffness: Ke';

switch conf.setup.optke

    case 1
        typeke=' EXp - Explicit matrix assembly ';  
    case 2
        typeke=' M3d – Multidimensional product ';   
    case 3
        typeke=' Triplet loops ';
    case 4
        typeke=' Triplet loops with MEX ';
    otherwise
        typeke=' Not implemented '; 
end

switch conf.setup.Ta

    case 1
        typekg=' sparse ';  
    case 2
        typekg=' sparse2 ';   
    case 3
        typekg=' fsparse ';
    case 4
        typekg=' sparsecreate ';
    otherwise
        typekg=' Not implemented '; 
end

switch conf.setup.Flag

    case 1
        typesol=' A/B ';  
    case 2
        typesol=' pcg ';   
    case 3
        typesol=' pcg_eigen ';
    case 4
        typesol=' pcg_eigen_OMP ';
    otherwise
        typesol=' Not implemented '; 
end

XKE =     ['Durante as análises foi utilizado a técnica ',...
    typeke,' para o cálculo das matrizes locais. O tempo',...
           '','necessário para efeituar esse cálculo foi ',...
      num2str(Part2),' (s). Esse tempo representou ',...
       num2str(round(100*(Part2/sum(0.001*Part)))),       ...
       ' % no tempo total das análise.'];
   
XKG =     ['Durante as análises foi utilizado a função ',...
    typekg,' para montar a matriz KG. O tempo',...
           '','necessário para efeituar esse cálculo foi ',...
      num2str(Part3),' (s). Esse tempo representou ',...
       num2str(round(100*(Part3/sum(0.001*Part)))),       ...
       ' % no tempo total das análise.'];  
   
XS =     ['Durante as análises foi utilizado o solver ',...
    typesol,' para resolver o sistema de equação linear. O tempo ',...
           '',' necessário para efeituar esse cálculo foi ',...
      num2str(Part6),' (s). Esse tempo representou ',...
       num2str(round(100*(Part6/sum(0.001*Part)))),       ...
       ' % no tempo total das análise.'];     
% str2 = 'Stiffness: KG';
% str3 = 'Stiffness: Solver';
a=annotation('textbox',[.1 .35 .25 .05],'String',...
    'local stiffness Ke','FitBoxToText','off');
t1=annotation('textbox',dim1,'String',XKE,'FitBoxToText','off');
b=annotation('textbox',[.4 .35 .25 .05],'String',...
    'global stiffness KG','FitBoxToText','off');
t2=annotation('textbox',dim2,'String',XKG,'FitBoxToText','off');
c=annotation('textbox',[.7 .35 .25 .05],'String','Solver','FitBoxToText','off');
t3=annotation('textbox',dim3,'String',XS ,'FitBoxToText','off');
t1.LineWidth=1;t2.LineWidth=1;t3.LineWidth=1;
a.LineWidth=2;b.LineWidth=2;c.LineWidth=2;
% a.Color=[1 0 0];b.Color=[1 0 0];c.Color=[0 1 0];
end

end

