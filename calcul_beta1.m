clear; clc


n=100000;
delta=0.01;
al=1;
au=5;
s1=0;
s2=0;
alpha_list=-1:0.01:1;


syms x

beta1=zeros(1,length(alpha_list));
beta2=zeros(1,length(alpha_list));
beta3=zeros(1,length(alpha_list));
beta4=zeros(1,length(alpha_list));
lambda1=zeros(1,length(alpha_list));
lambda2=zeros(1,length(alpha_list));
% for i=1:length(alpha_list)
% alpha=alpha_list(i);
% beta2(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*x/2)*exp(-x^2/2)/sqrt(2*pi),(al+delta/2),(au-delta/2)/abs(alpha))
% +int(abs((1-alpha)*abs(x/2)+(1+alpha)*x/2)*exp(-x^2/2)/sqrt(2*pi),-(au-delta/2)/abs(alpha),-(al+delta/2));
% beta1(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),(al+delta/2),(au-delta/2)/abs(alpha))
% +int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-(au-delta/2)/abs(alpha),-(al+delta/2))-beta2(i);
% beta4(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*exp(-x^2/2)/sqrt(2*pi),(al-delta/2),(au+delta/2)/abs(alpha))
% +int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*exp(-x^2/2)/sqrt(2*pi),-(au+delta/2)/abs(alpha),-(al-delta/2));
% beta3(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),(al-delta/2),(au+delta/2)/abs(alpha))
% +int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-(au+delta/2)/abs(alpha),-(al-delta/2))-beta4(i);
% end

n_list=-1:2;

% n = input('Enter a number: ');
for n=n_list
switch n
    case -1
    for i=1:length(alpha_list)
    alpha=alpha_list(i);
    if alpha<0
        beta2(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*x/2)*exp(-x^2/2)/sqrt(2*pi),al*(1+delta/2),au*(1-delta/2)/(-alpha));
        beta1(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),al*(1+delta/2),au*(1-delta/2)/(-alpha))-beta2(i);
        beta4(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*exp(-x^2/2)/sqrt(2*pi),al*(1-delta/2),au*(1+delta/2)/(-alpha));
        beta3(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),(al-delta/2),(au+delta/2)/abs(alpha))-beta4(i);    
    else
        beta2(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*x/2)*exp(-x^2/2)/sqrt(2*pi),-au*(1-delta/2)/alpha,-al*(1+delta/2));
        beta1(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-au*(1-delta/2)/alpha,-al*(1+delta/2))-beta2(i);
        beta4(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*exp(-x^2/2)/sqrt(2*pi),-au*(1+delta/2)/(alpha),-al*(1-delta/2));
        beta3(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-au*(1+delta/2)/(alpha),-al*(1-delta/2))-beta4(i);
    end
       lambda1(i)=(1-alpha)/2*beta1(i)+beta2(i)+((1+alpha)/2)^3;
       lambda2(i)=beta2(i);
    end
    plot(alpha_list,lambda1-lambda2,'blue-o')
    hold on
    case 0
    for i=1:length(alpha_list)
    alpha=alpha_list(i);
    if alpha<0
        beta2(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*x/2)*exp(-x^2/2)/sqrt(2*pi),-inf,inf);
        beta1(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-inf,inf)-beta2(i);
        beta4(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*exp(-x^2/2)/sqrt(2*pi),-inf,inf);
        beta3(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-inf,inf)-beta4(i);    
    else
        beta2(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*x/2)*exp(-x^2/2)/sqrt(2*pi),-inf,inf);
        beta1(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-inf,inf)-beta2(i);
        beta4(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*exp(-x^2/2)/sqrt(2*pi),-inf,inf);
        beta3(i)=int(abs((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-inf,inf)-beta4(i);
    end
       lambda1(i)=(1-alpha)/2*beta1(i)+beta2(i)+((1+alpha)/2)^3;
       lambda2(i)=beta2(i);
    end

    plot(alpha_list,lambda1-lambda2,'red-^')
    hold on
    case 1
    for i=1:length(alpha_list)
    alpha=alpha_list(i);
    if alpha<0
        beta2(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*x/2)*exp(-x^2/2)/sqrt(2*pi),al*(1+delta/2),au*(1-delta/2)/(-alpha));
        beta1(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),al*(1+delta/2),au*(1-delta/2)/(-alpha))-beta2(i);
        beta4(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*exp(-x^2/2)/sqrt(2*pi),al*(1-delta/2),au*(1+delta/2)/(-alpha));
        beta3(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),(al-delta/2),(au+delta/2)/abs(alpha))-beta4(i);    
    else
        beta2(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*x/2)*exp(-x^2/2)/sqrt(2*pi),-au*(1-delta/2)/alpha,-al*(1+delta/2));
        beta1(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-au*(1-delta/2)/alpha,-al*(1+delta/2))-beta2(i);
        beta4(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*exp(-x^2/2)/sqrt(2*pi),-au*(1+delta/2)/(alpha),-al*(1-delta/2));
        beta3(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-au*(1+delta/2)/(alpha),-al*(1-delta/2))-beta4(i);
    end
       lambda1(i)=(1-alpha)/2*beta1(i)+beta2(i)+((1+alpha)/2)^3;
       lambda2(i)=beta2(i);
    end

    plot(alpha_list,lambda1-lambda2,'green-*')
    hold on

    otherwise
     for i=1:length(alpha_list)
     alpha=alpha_list(i);
     if alpha<0
         beta2(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*x/2)*exp(-x^2/2)/sqrt(2*pi),-inf,inf);
         beta1(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-inf,inf)-beta2(i);
         beta4(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*exp(-x^2/2)/sqrt(2*pi),-inf,inf);
         beta3(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-inf,inf)-beta4(i);    
     else
         beta2(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*x/2)*exp(-x^2/2)/sqrt(2*pi),-inf,inf);
         beta1(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-inf,inf)-beta2(i);
         beta4(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*exp(-x^2/2)/sqrt(2*pi),-inf,inf);
         beta3(i)=int(((1-alpha)*abs(x/2)+(1+alpha)*(x/2))*x^2*exp(-x^2/2)/sqrt(2*pi),-inf,inf)-beta4(i);
     end
        lambda1(i)=(1-alpha)/2*beta1(i)+beta2(i)+((1+alpha)/2)^3;
        lambda2(i)=beta2(i);
     end
     plot(alpha_list,lambda1-lambda2,'black-v')
     hold on
end




   
end

 set(leg1,'Interpreter','latex');
    set(leg1,'FontSize',12);
    xlabel('\alpha')
    ylabel('gap of eigenvalue')
% for i=1:n
%    g=normrnd(0,1); 
%    v=(1-alpha)/2*abs(g)+(1+alpha)/2*g;
%     if  (al*(1+epsilon)<v) && (v<au*(1-epsilon))
%     s1=s1+v*g^2;
%     s2=s2+v;
%     end
% end
% output1=(1/n)*(s1-s2)
% output2=(1/n)*(s2)