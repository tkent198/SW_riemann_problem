clear;
tn = 0:0.5:1;
hl = 1;
hr = 1;
ul = 0;
ur = 1;

for i = 1:length(tn)
    
    [hexact,uexact] = SWRPfunplot(hl,hr,ul,ur,tn(i));
    
    hfig = figure(123);
    subplot(length(tn),1,i);
    fplot(hexact, [-8,8]);
    str = sprintf('h at t=%0.2g ',tn(i));
    title(str,'fontsize',14);
    set(hfig, 'Position', [0 100 300 500*length(tn)/3]);
    
    ufig = figure(456);
    subplot(length(tn),1,i);
    fplot(uexact, [-8,8]);
    str = sprintf('u at t=%0.2g ',tn(i));
    title(str,'fontsize',14);
    set(ufig, 'Position', [300 100 300 500*length(tn)/3]);
    
end

