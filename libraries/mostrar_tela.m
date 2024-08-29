function  mostrar_tela(desk,nome_link,link_site)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
  if desk
       fprintf('<a href = "%s">', link_site);
  end
       fprintf('%s', nome_link);
     if desk
        fprintf('</a>');
    end
        fprintf('\n');
end

