function G = Grid_mrst2sim(GMRST)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
G.elements.lnods=delaunay(GMRST.nodes.coords);
G.elements.nelem=size(G.elements.lnods,1);
G.nodes.coords=GMRST.nodes.coords;
G.nodes.num=size(GMRST.nodes.coords,1);
end

