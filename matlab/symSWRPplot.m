function symSWRPplot(hl,hr,ul,ur,vl,vr)

% Given Riemann initial data, function plots the (1D) shallow water Riemann
% problem: variable (h, u, or v) against similarity variable x/t. The value
% for the Riemann flux is at x/t = 0.
% e.g. SWRPplot(100,50,10,50)


g=9.81;

% first, determine 4 candidate star states:
hstar = SWEstarstate(hl,hr,ul,ur);

% second, given the 4 star values determine which one is correct:
if (hstar(4) < hl && hstar(4) < hr) % for LWRW
    
    hstar = hstar(4);
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
    
    subplot(3,1,1)
    fplot(@(x) piecewise_eval(x,[Slhead Sltail Srhead Srtail],{hl,LWfan,hstar,RWfan,hr}),[2*Slhead,2*Srtail])
    xlabel('x/t','fontsize',14); ylabel('h','fontsize',14);
    title([]);
    
    subplot(3,1,2)
    fplot(@(x) piecewise_eval(x,[Slhead Sltail Srhead Srtail],{ul,LWfanu,ustar,RWfanu,ur}),[2*Slhead,2*Srtail])
    xlabel('x/t','fontsize',14); ylabel('u','fontsize',14);
    title([]);
    
    subplot(3,1,3)
    fplot(@(x) piecewise_eval(x,[ustar],{vl,vr}),[2*Slhead,2*Srtail])
    xlabel('x/t','fontsize',14); ylabel('v','fontsize',14);
    title([]);  
    
    set(gcf, 'Position', [0 100 300 500]);
    
elseif (hstar(3) > hl && hstar(3) < hr) % for LSRW
    
    hstar = hstar(3);
    ustar = 0.5*(ul+ur) + 0.5*(2*sqrt(g)*(sqrt(hstar) - sqrt(hr)) -...
        (hstar-hl)*sqrt(g/2)*sqrt(1/hstar + 1/hl));
    
    Sl = ul - (1/hl)*sqrt(g/2)*sqrt(hl*hstar*(hl+hstar)); % left shock speed
    Srhead = ustar + sqrt(g*hstar);
    Srtail = ur + sqrt(g*hr);
    RWfan = @(xbyt) (1/(9*g))*(xbyt - ur + 2*sqrt(g*hr)).^2;
    RWfanu = @(xbyt) ur + 2*((1/3)*(xbyt - ur + 2*sqrt(g*hr)) - sqrt(g*hr));
    
    
    subplot(3,1,1)
    fplot(@(x) piecewise_eval(x,[Sl Srhead Srtail],{hl,hstar,RWfan,hr}),[2*Sl,2*Srtail])
    xlabel('x/t','fontsize',14); ylabel('h','fontsize',14);
    title([]);
    
    subplot(3,1,2)
    fplot(@(x) piecewise_eval(x,[Sl Srhead Srtail],{ul,ustar,RWfanu,ur}),[2*Sl,2*Srtail])
    xlabel('x/t','fontsize',14); ylabel('u','fontsize',14);
    title([]);
    
    subplot(3,1,3)
    fplot(@(x) piecewise_eval(x,[ustar],{vl,vr}),[2*Sl,2*Srtail])
    xlabel('x/t','fontsize',14); ylabel('v','fontsize',14);
    title([]);  
    
    set(gcf, 'Position', [0 100 300 500]);
    
elseif (hstar(2) < hl && hstar(2) > hr) % for LWRS
    
    hstar = hstar(2);
    ustar = 0.5*(ul+ur) + 0.5*((hstar-hr)*sqrt(g/2)*sqrt(1/hstar + 1/hr) -...
        2*sqrt(g)*(sqrt(hstar) - sqrt(hl)));
    
    Sr = ur + (1/hr)*sqrt(g/2)*sqrt(hr*hstar*(hr+hstar)); % right shock speed
    Slhead = ul - sqrt(g*hl);
    Sltail = ustar - sqrt(g*hstar);
    LWfan = @(xbyt) (1/(9*g))*(ul + 2*sqrt(g*hl) - xbyt).^2;
    LWfanu = @(xbyt) ul + 2*(sqrt(g*hl) - (ul + 2*sqrt(g*hl) - xbyt)/3);
    
    
    subplot(3,1,1)
    fplot(@(x) piecewise_eval(x,[Slhead Sltail Sr],{hl,LWfan,hstar,hr}),[2*Slhead,2*Sr])
    xlabel('x/t','fontsize',14); ylabel('h','fontsize',14);
    title([]);
    
    subplot(3,1,2)
    fplot(@(x) piecewise_eval(x,[Slhead Sltail Sr],{ul,LWfanu,ustar,ur}),[2*Slhead,2*Sr])
    xlabel('x/t','fontsize',14); ylabel('u','fontsize',14);
    title([]);    
    
    subplot(3,1,3)
    fplot(@(x) piecewise_eval(x,[ustar],{vl,vr}),[2*Slhead,2*Sr])
    xlabel('x/t','fontsize',14); ylabel('v','fontsize',14);
    title([]);  
    
    set(gcf, 'Position', [0 100 300 500]);
    
else % LSRS
    
    hstar = hstar(1);
    ustar = 0.5*(ul+ur) + 0.5*((hstar-hr)*sqrt(g/2)*sqrt(1/hstar + 1/hr) -...
        (hstar-hl)*sqrt(g/2)*sqrt(1/hstar + 1/hl));
    
    Sl = ul - (1/hl)*sqrt(g/2)*sqrt(hl*hstar*(hl+hstar)); % left shock speed
    Sr = ur + (1/hr)*sqrt(g/2)*sqrt(hr*hstar*(hr+hstar)); % right shock speed

    
    subplot(3,1,1);
    fplot(@(x) piecewise_eval(x,[Sl Sr],{hl,hstar,hr}),[2*Sl,2*Sr])
    xlabel('x/t','fontsize',14); ylabel('h','fontsize',14);
    title([]);
    
    subplot(3,1,2);
    fplot(@(x) piecewise_eval(x,[Sl Sr],{ul,ustar,ur}),[2*Sl,2*Sr])
    xlabel('x/t','fontsize',14); ylabel('u','fontsize',14);
    title([]);
    
    subplot(3,1,3)
    fplot(@(x) piecewise_eval(x,[ustar],{vl,vr}),[2*Sl,2*Sr])
    xlabel('x/t','fontsize',14); ylabel('v','fontsize',14);
    title([]);  
    
    set(gcf, 'Position', [0 100 300 500]);
    
    
end
end