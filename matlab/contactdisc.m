%
% Plot in the x-t plane showing the solution for 1d
% symmetric SW Riemann problem: (h,u,v) with contact discontinuity in v

%
% example speeds for given example:
Sl = -3;
Sr = 4;
Sltail = -4;
Slhead = -2;
Scontact = 1;

figure(1);
fplot(@(x) x/Sltail,'k'); hold on;
fplot(@(x) x/Sl,'k'); hold on;
fplot(@(x) x/Slhead,'k'); hold on;
fplot(@(x) x/Sr,'k'); hold on;
fplot(@(x) x/Scontact,'k'); hold on;
text(-Sl,0.75,['Right shock'],'fontsize',14,'HorizontalAlignment','center');
text(Sl+1,0.6,['Left rarefaction'],'fontsize',14,'HorizontalAlignment','center');
text(Scontact,0.9,['Contact'],'fontsize',14,'HorizontalAlignment','center');
text(-Sl,0.25,['(h_r, u_r, v_r)'],'fontsize',12,'HorizontalAlignment','center');
text(Sl,0.25,['(h_l, u_l, v_l)'],'fontsize',12,'HorizontalAlignment','center');
text(-0.5,0.8,['(h*, u*, v_l)'],'fontsize',12,'HorizontalAlignment','center');
text(1.6,0.6,['(h*, u*, v_r)'],'fontsize',12,'HorizontalAlignment','center');
axis([Sltail -Sltail 0 1]);
xlabel('x','fontsize',14); ylabel('t','fontsize',14);
title([]);
set(gcf, 'Position', [0 100 450 300]);