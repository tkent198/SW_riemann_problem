
% syms h 
hl=1; hr=2; ul=0; ur=0;

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
hstar_vec=zeros(1,4);

% compute hstar, either numerically (rootfinder.m) or explicitly
hstar_vec(1) = rootfinder(hl,hr,ul,ur,GLSRS,GLSRSprime);
hstar_vec(2) = rootfinder(hl,hr,ul,ur,GLWRS,GLWRSprime);
hstar_vec(3) = rootfinder(hl,hr,ul,ur,GLSRW,GLSRWprime);
hstar_vec(4) = hlwrw;

if (hstar_vec(4) < hl && hstar_vec(4) < hr) % for LWRW
    
    hstar = hstar_vec(4);
    ustar = 0.5*(ul + ur + 2*sqrt(g)*(sqrt(hstar) - sqrt(hr)) - ...
        2*sqrt(g)*(sqrt(hstar) - sqrt(hl)));
    
    Slhead = ul - sqrt(g*hl);
    Sltail = ustar - sqrt(g*hstar);
    LWfan = @(xbyt) (1/(9*g))*(ul + 2*sqrt(g*hl) - xbyt).^2;
    LWfanu = @(xbyt) ul + 2*(sqrt(g*hl) - (ul + 2*sqrt(g*hl) - xbyt)/3);
    Srhead = ustar + sqrt(g*hstar);
    Srtail = ur + sqrt(g*hr);
    RWfan = @(xbyt) (1/(9*g))*(xbyt - ur + 2*sqrt(g*hr)).^2;
    RWfanu = @(xbyt) ur + 2*((1/3)*(xbyt - ur + 2*sqrt(g*hr)) - sqrt(g*hr));
    
    hflux = piecewise_eval(0,[Slhead Sltail Srhead Srtail],{hl,LWfan,hstar,RWfan,hr});
    uflux = piecewise_eval(0,[Slhead Sltail Srhead Srtail],{ul,LWfanu,ustar,RWfanu,ur});
    
    subplot(2,1,1)
    fplot(@(x) piecewise_eval(x,[Slhead Sltail Srhead Srtail],{hl,LWfan,hstar,RWfan,hr}),[2*Slhead,2*Srtail])
%     axis([2*Slhead 2*Srtail 0 2]);
    hold on;
    vline(0); hold off;
    xlabel('x/t','fontsize',14); ylabel('h','fontsize',14);
    title('Shallow water Riemann problem: LW-RW','fontsize',14);
    
    subplot(2,1,2)
    fplot(@(x) piecewise_eval(x,[Slhead Sltail Srhead Srtail],{ul,LWfanu,ustar,RWfanu,ur}),[2*Slhead,2*Srtail])
%     axis([2*Slhead 2*Srtail 0 6]);
    hold on;
    vline(0); hold off;
    xlabel('x/t','fontsize',14); ylabel('u','fontsize',14);
    title([]);
    
    
elseif (hstar_vec(3) > hl && hstar_vec(3) < hr) % for LSRW
    
    hstar = hstar_vec(3);
    ustar = 0.5*(ul+ur) + 0.5*(2*sqrt(g)*(sqrt(hstar) - sqrt(hr)) -...
        (hstar-hl)*sqrt(g/2)*sqrt(1/hstar + 1/hl));
    
    Sl = ul - (1/hl)*sqrt(g/2)*sqrt(hl*hstar*(hl+hstar)); % left shock speed
    Srhead = ustar + sqrt(g*hstar);
    Srtail = ur + sqrt(g*hr);
    RWfan = @(xbyt) (1/(9*g))*(xbyt - ur + 2*sqrt(g*hr)).^2;
    RWfanu = @(xbyt) ur + 2*((1/3)*(xbyt - ur + 2*sqrt(g*hr)) - sqrt(g*hr));
    
    hflux = piecewise_eval(0,[Sl Srhead Srtail],{hl,hstar,RWfan,hr});
    uflux = piecewise_eval(0,[Sl Srhead Srtail],{ul,ustar,RWfanu,ur});
    
    subplot(2,1,1)
    fplot(@(x) piecewise_eval(x,[Sl Srhead Srtail],{hl,hstar,RWfan,hr}),[2*Sl,2*Srtail])
%     axis([2*Sl 2*Srtail 0 2]);
    hold on;
    vline(0); hold off;
    xlabel('x/t','fontsize',14); ylabel('h','fontsize',14);
    title('Shallow water Riemann problem: LS-RW','fontsize',14);
    
    subplot(2,1,2)
    fplot(@(x) piecewise_eval(x,[Sl Srhead Srtail],{ul,ustar,RWfanu,ur}),[2*Sl,2*Srtail])
%     axis([2*Sl 2*Srtail 0 2]);
    hold on;
    vline(0); hold off;
    xlabel('x/t','fontsize',14); ylabel('u','fontsize',14);
    title([]);
    
elseif (hstar_vec(2) < hl && hstar_vec(2) > hr) % for LWRS
    
    hstar = hstar_vec(2);
    ustar = 0.5*(ul+ur) + 0.5*((hstar-hr)*sqrt(g/2)*sqrt(1/hstar + 1/hr) -...
        2*sqrt(g)*(sqrt(hstar) - sqrt(hl)));
    
    Sr = ur + (1/hr)*sqrt(g/2)*sqrt(hr*hstar*(hr+hstar)); % right shock speed
    Slhead = ul - sqrt(g*hl);
    Sltail = ustar - sqrt(g*hstar);
    LWfan = @(xbyt) (1/(9*g))*(ul + 2*sqrt(g*hl) - xbyt).^2;
    LWfanu = @(xbyt) ul + 2*(sqrt(g*hl) - (ul + 2*sqrt(g*hl) - xbyt)/3);
    
    hflux = piecewise_eval(0,[Slhead Sltail Sr],{hl,LWfan,hstar,hr});
    uflux = piecewise_eval(0,[Slhead Sltail Sr],{ul,LWfanu,ustar,ur});
    
    subplot(2,1,1)
    fplot(@(x) piecewise_eval(x,[Slhead Sltail Sr],{hl,LWfan,hstar,hr}),[2*Slhead,2*Sr])
%     axis([2*Slhead 2*Sr 0 2]);
    hold on;
    vline(0); hold off;
    xlabel('x/t','fontsize',14); ylabel('h','fontsize',14);
    title('Shallow water Riemann problem: LW-RS','fontsize',14);
    
    subplot(2,1,2)
    fplot(@(x) piecewise_eval(x,[Slhead Sltail Sr],{ul,LWfanu,ustar,ur}),[2*Slhead,2*Sr])
%     axis([2*Slhead 2*Sr 0 2]);
    hold on;
    vline(0); hold off;
    xlabel('x/t','fontsize',14); ylabel('u','fontsize',14);
    title([]);    
    
    
else % LSRS
    
    hstar = hstar_vec(1);
    ustar = 0.5*(ul+ur) + 0.5*((hstar-hr)*sqrt(g/2)*sqrt(1/hstar + 1/hr) -...
        (hstar-hl)*sqrt(g/2)*sqrt(1/hstar + 1/hl));
    
    Sl = ul - (1/hl)*sqrt(g/2)*sqrt(hl*hstar(1)*(hl+hstar(1))); % left shock speed
    Sr = ur + (1/hr)*sqrt(g/2)*sqrt(hr*hstar(1)*(hr+hstar(1))); % right shock speed
    
    hflux = piecewise_eval(0,[Sl Sr],{hl,hstar,hr});
    uflux = piecewise_eval(0,[Sl Sr],{ul,ustar,ur});
    
    subplot(2,1,1);
    fplot(@(x) piecewise_eval(x,[Sl Sr],{hl,hstar,hr}),[2*Sl,2*Sr])
%     axis([2*Sl 2*Sr 0 2]);
    hold on;
    vline(0); hold off;
    xlabel('x/t','fontsize',14); ylabel('h','fontsize',14);
    title('Shallow water Riemann problem: LS-RS','fontsize',14);
    
    subplot(2,1,2);
    fplot(@(x) piecewise_eval(x,[Sl Sr],{ul,ustar,ur}),[2*Sl,2*Sr])
%     axis([2*Sl 2*Sr 0 2]);
    hold on;
    vline(0); hold off;
    xlabel('x/t','fontsize',14); ylabel('u','fontsize',14);
    title([]);
    
    
end