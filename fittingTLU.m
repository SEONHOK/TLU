clear all;
clc;

rng(1);
K=50; %total number of iterations
d_list=100; %dimension
n_list=8*d_list;%# of samples
total_iteration=50; %Total iteration for fixed parameter, dimension, and the number of observations.
eta=0.5;% stepsize
sigma=0;
al=1;
au=5;
a=-0.5;
error_1=[];
error_2=[];
error_3=[];

% w0=make_gtrthpar(d); % size d 

for j=1:length(d_list)
    d=d_list(j);
    n=n_list(j);
    loss_mat=[];
    w0=make_gtrthpar(d); % size d 
    zero_vector=zeros(size(w0));

    for t=1:total_iteration
        w=[];
        rng(t)
        X_sample=randn(n,d);  %sample size n x d
        y=leakyReLU(w0,X_sample,a)+sigma*randn(size(leakyReLU(w0,X_sample,a))); 
        [w_tmp,lambda]=Specinit_Fin3(X_sample,y,al,au,a,w0); % ghosh's method   
        w_tmp_0=Specinit_Fin5(X_sample,y,al,au,a);  % Proposed Method
        [w_tmp_1,lambda1]=Specinit_Fin(X_sample,y,al,au,a); % Previous proposed method
        w_tmp2=zero_vector-2/(1+a)*leakyReLU_gradient(y,zero_vector,n,X_sample,a); %Full gradient
         if w_tmp'*w0<0
            w_tmp=-w_tmp; 
         end
         if w_tmp_0'*w0<0
            w_tmp_0=-w_tmp_0; 
         end
          if w_tmp_1'*w0<0
            w_tmp_1=-w_tmp_1; 
          end
          if w_tmp2'*w0<0
            w_tmp2=-w_tmp2; 
         end
        loss1=[];
        loss2=[];
        loss3=[];
        loss4=[];
        for k=1:K
              
             w_tmp=w_tmp-eta*leakyReLU_gradient(y,w_tmp,n,X_sample,a);    %gradient descent step from ghosh's
            w_tmp_0=w_tmp_0-eta*leakyReLU_gradient(y,w_tmp_0,n,X_sample,a);    %gradient descent step from proposed method
             w_tmp_1=w_tmp_1-eta*leakyReLU_gradient(y,w_tmp_1,n,X_sample,a);    %gradient descent step from previous proposed method
             w_tmp2=w_tmp2-eta*leakyReLU_gradient(y,w_tmp2,n,X_sample,a);    %gradient descent step from full gradient
             
             loss1=[loss1 norm(w_tmp-w0)/norm(w0)];
            loss2=[loss2 norm(w_tmp_0-w0)/norm(w0)];
             loss3=[loss3 norm(w_tmp_1-w0)/norm(w0)];
             loss4=[loss4 norm(w_tmp2-w0)/norm(w0)];
           
        end   
                 plot(1:K,loss2,':red')
                 hold on
%              plot(1:K,loss1,':blue')
%               hold on
%              plot(1:K,loss3,':black')
%              hold on
%              plot(1:K,loss4,':green')
%              hold on
%              legend('Ghosh','Proposed','PreProposed','Fullgrad')
    end
    set(gca,'FontSize',25)
    ylabel('Normalized Estimation Error','interpreter','LaTeX','FontSize', 25, 'FontName', 'Times New Roman')
    xlabel('The number of iteration','FontSize', 20, 'FontName', 'Times New Roman') 
  
end