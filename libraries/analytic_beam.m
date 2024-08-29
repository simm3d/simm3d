function disp = analytic_beam(L,P,E)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
I=L(2)*L(3)^3/12;
disp=P*L(1)^3/(3*E*I);
end

