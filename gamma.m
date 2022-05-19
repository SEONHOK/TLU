clear all;
clc;

a=-1:0.01:1;
y=1.05*a.^2+0.55*(1-a.^2)+7*(1-a)/120*(1+2*sqrt(21/20));
plot(a,y,'LineWidth',2)

set(gca,'FontSize',25)
 ylabel('\rho_\alpha','FontSize', 30, 'FontName', 'Times New Roman')
 xlabel('\alpha','FontSize', 30, 'FontName', 'Times New Roman') 
