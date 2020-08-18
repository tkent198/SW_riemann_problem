%
% Plot: The four admissible solutions of the Riemann problem: (a) left
% shock and right shock,(b) left rarefaction and right shock, (c) left
% shock and right rarefaction, and (d) left rarefaction and right
% rarefaction. Note that the characteristics need not be positioned to the
% left and right of the t-axis, as illustrated here. As long as the left
% wave lies to the left of the right wave, the characteristics may lie
% anywhere on the x-t-plane with t > 0.

clear; clf;

Sl = -2;
Sr = 3;
Sltail = -3;
Slhead = -1;
Srtail = 2;
Srhead = 4;

figure(2);
subplot(2,2,1) % characteristic structure plot
fplot(@(x) x/Sl,'k'); hold on;
fplot(@(x) x/Sr,'k'); hold on;
text(Sl,0.1,['(a) LS-RS'],'fontsize',14,'HorizontalAlignment','center');
axis([2*Sl -2*Sl 0 1]);
xlabel('x','fontsize',14); ylabel('t','fontsize',14);
title([]);


subplot(2,2,2) % characteristic structure plot
fplot(@(x) x/Sltail,'k'); hold on;
fplot(@(x) x/Sl,'k'); hold on;
fplot(@(x) x/Slhead,'k'); hold on;
fplot(@(x) x/Sr,'k'); hold on;
text(Sl,0.1,['(b) LW-RS'],'fontsize',14,'HorizontalAlignment','center');
axis([2*Sl -2*Sl 0 1]);
xlabel('x','fontsize',14); ylabel('t','fontsize',14);
title([]);

subplot(2,2,3) % characteristic structure plot
fplot(@(x) x/Sl,'k'); hold on;
fplot(@(x) x/Srtail,'k'); hold on;
fplot(@(x) x/Sr,'k'); hold on;
fplot(@(x) x/Srhead,'k'); hold on;
text(Sl,0.1,['(c) LS-RW'],'fontsize',14,'HorizontalAlignment','center');
axis([2*Sl -2*Sl 0 1]);
xlabel('x','fontsize',14); ylabel('t','fontsize',14);
title([]);

subplot(2,2,4) % characteristic structure plot
fplot(@(x) x/Sltail,'k'); hold on;
fplot(@(x) x/Sl,'k'); hold on;
fplot(@(x) x/Slhead,'k'); hold on;
fplot(@(x) x/Srtail,'k'); hold on;
fplot(@(x) x/Sr,'k'); hold on;
fplot(@(x) x/Srhead,'k'); hold on;
text(Sl,0.1,['(d) LW-RW'],'fontsize',14,'HorizontalAlignment','center');
axis([2*Sl -2*Sl 0 1]);
xlabel('x','fontsize',14); ylabel('t','fontsize',14);
title([]);