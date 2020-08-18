function [fun1,fun2] = SWRPfunplot(hl,hr,ul,ur,t)

% Given Riemann initial data (hl,hr,ul,ur) SWRPfunplot gives functions in x for the exact
% solution to the (1D) shallow water Riemann problem at time t,
% i.e. variable (h, u, or v) against variable x at given time t. The value
% for the Riemann flux is at x = 0.
%
% e.g. SWRPfunplot(2,1,0,0,1)
%
% OUTPUT:
% fun1: function h(x;t) for given t
% fun2: function u(x;t) for given t

g=9.81;

%
% first, determine the 4 candidate star states
%

hstar = SWEstarstate(hl,hr,ul,ur);

%
% Second, given the 4 star values determine which one is correct
%
if (t==0)
    
    fun1 = @(x) piecewise_eval(x,[0],{hl,hr});
    fun2 = @(x) piecewise_eval(x,[0],{ul,ur});
    
else
    
    if (hstar(4) < hl && hstar(4) < hr) % for LWRW
        
        hstar = hstar(4);
        ustar = 0.5*(ul + ur + 2*sqrt(g)*(sqrt(hstar) - sqrt(hr)) - ...
            2*sqrt(g)*(sqrt(hstar) - sqrt(hl)));
        
        Slhead = ul - sqrt(g*hl);
        Sltail = ustar - sqrt(g*hstar);
        LWfan = @(x) (1/(9*g))*(ul + 2*sqrt(g*hl) - x/t).^2;
        LWfanu = @(x) ul + 2*(sqrt(g*hl) - (ul + 2*sqrt(g*hl) - x/t)/3);
        Srhead = ustar + sqrt(g*hstar);
        Srtail = ur + sqrt(g*hr);
        RWfan = @(x) (1/(9*g))*(x/t - ur + 2*sqrt(g*hr)).^2;
        RWfanu = @(x) ur + 2*((1/3)*(x/t - ur + 2*sqrt(g*hr)) - sqrt(g*hr));
        
        
        fun1 = @(x) piecewise_eval(x,[Slhead*t Sltail*t Srhead*t Srtail*t],{hl,LWfan,hstar,RWfan,hr});
        fun2 = @(x) piecewise_eval(x,[Slhead*t Sltail*t Srhead*t Srtail*t],{ul,LWfanu,ustar,RWfanu,ur});
        
        
    elseif (hstar(3) > hl && hstar(3) < hr) % for LSRW
        
        hstar = hstar(3);
        ustar = 0.5*(ul+ur) + 0.5*(2*sqrt(g)*(sqrt(hstar) - sqrt(hr)) -...
            (hstar-hl)*sqrt(g/2)*sqrt(1/hstar + 1/hl));
        
        Sl = ul - (1/hl)*sqrt(g/2)*sqrt(hl*hstar*(hl+hstar)); % left shock speed
        Srhead = ustar + sqrt(g*hstar);
        Srtail = ur + sqrt(g*hr);
        RWfan = @(x) (1/(9*g))*(x/t - ur + 2*sqrt(g*hr)).^2;
        RWfanu = @(x) ur + 2*((1/3)*(x/t - ur + 2*sqrt(g*hr)) - sqrt(g*hr));
        
        fun1 = @(x) piecewise_eval(x,[Sl*t Srhead*t Srtail*t],{hl,hstar,RWfan,hr});
        fun2 = @(x) piecewise_eval(x,[Sl*t Srhead*t Srtail*t],{ul,ustar,RWfanu,ur});
        
    elseif (hstar(2) < hl && hstar(2) > hr) % for LWRS
        
        hstar = hstar(2);
        ustar = 0.5*(ul+ur) + 0.5*((hstar-hr)*sqrt(g/2)*sqrt(1/hstar + 1/hr) -...
            2*sqrt(g)*(sqrt(hstar) - sqrt(hl)));
        
        Sr = ur + (1/hr)*sqrt(g/2)*sqrt(hr*hstar*(hr+hstar)); % right shock speed
        Slhead = ul - sqrt(g*hl);
        Sltail = ustar - sqrt(g*hstar);
        LWfan = @(x) (1/(9*g))*(ul + 2*sqrt(g*hl) - x/t).^2;
        LWfanu = @(x) ul + 2*(sqrt(g*hl) - (ul + 2*sqrt(g*hl) - x/t)/3);
        
        fun1 = @(x) piecewise_eval(x,[Slhead*t Sltail*t Sr*t],{hl,LWfan,hstar,hr});
        fun2 = @(x) piecewise_eval(x,[Slhead*t Sltail*t Sr*t],{ul,LWfanu,ustar,ur});
        
    else % LSRS
        
        hstar = hstar(1);
        ustar = 0.5*(ul+ur) + 0.5*((hstar-hr)*sqrt(g/2)*sqrt(1/hstar + 1/hr) -...
            (hstar-hl)*sqrt(g/2)*sqrt(1/hstar + 1/hl));
        
        Sl = ul - (1/hl)*sqrt(g/2)*sqrt(hl*hstar*(hl+hstar)); % left shock speed
        Sr = ur + (1/hr)*sqrt(g/2)*sqrt(hr*hstar*(hr+hstar)); % right shock speed
        
        fun1 = @(x) piecewise_eval(x,[Sl*t Sr*t],{hl,hstar,hr});
        fun2 = @(x) piecewise_eval(x,[Sl*t Sr*t],{ul,ustar,ur});
        
    end
end

fun1=fun1;
fun2=fun2;

end