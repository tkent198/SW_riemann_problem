function [hstar] = SWEstarstate(hl,hr,ul,ur)

%
%  Given left and right states, function determines the 4 candidate star
%  states for pseudo-density h.
%
% INPUT: hl, hr, ul, ur.
% Note: work with U = (h,u) so that hl = Ul(1), hr = Ur(1), ul = Ul(2)/hl, 
% ur = Ur(2)/hr if U = (h,hu)
%
% OUTPUT: hstar, vector with 4 entries corresponding to star states: 
% (1) LSRS, (2) LWRS, (3) LSRW, (4) LWRW
%

g=9.81;

% LS RS
GLSRS = @(h) (h-hl)*sqrt(g/2)*sqrt(1/h + 1/hl) + (h-hr)*sqrt(g/2)*sqrt(1/h + 1/hr) + ...
    ur - ul;
GLSRSprime = @(h) sqrt(g/2)*(sqrt(1/h + 1/hl) - 0.5*(h-hl)*h^(-2)*(1/h + 1/hl)^(-0.5) +...
    sqrt(1/h + 1/hr) - 0.5*(h-hr)*h^(-2)*(1/h + 1/hr)^(-0.5));

% LW RS
GLWRS = @(h) 2*sqrt(g)*(sqrt(h) - sqrt(hl)) + (h-hr)*sqrt(g/2)*sqrt(1/h + 1/hr) + ...
    ur - ul;
GLWRSprime = @(h)  sqrt(g/h) + sqrt(g/2)*(sqrt(1/h + 1/hr) -...
    0.5*(h-hr)*h^(-2)*(1/h + 1/hr)^(-0.5));

% LS RW
GLSRW = @(h) 2*sqrt(g)*(sqrt(h) - sqrt(hr)) + (h-hl)*sqrt(g/2)*sqrt(1/h + 1/hl) + ...
    ur - ul;
GLSRWprime = @(h)  sqrt(g/h) + sqrt(g/2)*(sqrt(1/h + 1/hl) -...
    0.5*(h-hl)*h^(-2)*(1/h + 1/hl)^(-0.5));

% LW RW (explicit)
hlwrw = (1/(16*g))*(ul-ur+2*sqrt(g)*(sqrt(hl) + sqrt(hr)))^2;

% star states: (1) LSRS, (2) LWRS, (3) LSRW, (4) LWRW

hstar=zeros(1,4);

% compute hstar, either numerically (rootfinder.m) or explicitly
hstar(1) = rootfinder(hl,hr,ul,ur,GLSRS,GLSRSprime);
hstar(2) = rootfinder(hl,hr,ul,ur,GLWRS,GLWRSprime);
hstar(3) = rootfinder(hl,hr,ul,ur,GLSRW,GLSRWprime);
hstar(4) = hlwrw;

end