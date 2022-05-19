clear all
clc

x_list=-1:0.01:1;
alpha=-1:0.05:1
y=zeros(size(x_list));
for a=alpha
    for i=1:length(x_list)
        x=x_list(i);
        y(i)=max(x,a*x)
    end
    plot(x_list,y,'b')
    hold on
end
set(gca,'FontSize',25)
 ylabel('y','interpreter','LaTeX','FontSize', 25, 'FontName', 'Times New Roman')
 xlabel('x','FontSize', 25, 'FontName', 'Times New Roman') 
