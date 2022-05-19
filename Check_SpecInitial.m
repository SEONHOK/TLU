clear all;
clc;

rng(2);
K=50; %total number of iterations
% d_list=[50,100]; %dimension
% n=10*d_list;%# of samples
d=50;
n=10*d;
total_iteration=50; %Total iteration for fixed parameter, dimension, and the number of observations.
sigma=0;
al=1;
au=5;
a=-1;
a_list=-1:0.01:1;
% stepsize
error_1=[];
error_2=[];
error_3=[];
rel_error1=[];
rel_error2=[];
rel_error3=[];
rel_error4=[];
rel_error5=[];

    
   fname_proposed = ['Proposed'  'sigma' num2str(sigma) 'd' num2str(d) 'n' num2str(n) '.mat'];      
   fname_phase = ['Phase'  'sigma' num2str(sigma) 'd' num2str(d) 'n' num2str(n) '.mat'];            
   fname_gradient = ['Gradient'  'sigma' num2str(sigma) 'd' num2str(d) 'n' num2str(n) '.mat'];
                       
    
    
 for i=1:length(a_list)
    
    eta=2;    
    a=a_list(i);
    w0=make_gtrthpar(d); % size d 
    w=[];
  
    zero_vector=zeros(size(w0));
    error1=0;
    error2=0;
    error3=0;
    error4=0;
    error5=0;
    test=[];
    for t=1:total_iteration
    X_sample=randn(n,d);  %sample size n x d
%     y=abs(X_sample*w0);
    y_1=ReLU(w0,X_sample); 
    rng(0)
    y=leakyReLU(w0,X_sample,a)+sigma*randn(size(leakyReLU(w0,X_sample,a))); 
      

    w_tmp_0=Specinit_Proposed(X_sample,y,a);  % Proposed Method
    [w_tmp_1,lambda1]=Specinit_Fin(X_sample,y,al,au,a); % Phase Retrieval
    error2=error2+min(norm(w_tmp_0-w0)/norm(w0),norm(-w_tmp_0-w0)/norm(w0));
     error3=error3+min(norm(w_tmp_1-w0)/norm(w0),norm(-w_tmp_1-w0)/norm(w0));
    w_tmp2=zero_vector-eta*leakyReLU_gradient(y,zero_vector,n,X_sample,a); %Full gradient

    error4=error4+norm(w_tmp2-w0)/norm(w0);
    
    end
    rel_error2=[rel_error2,error2/total_iteration];  %proposed method
%     rel_error3=[rel_error3,error3/total_iteration]; %previous proposed method
    rel_error4=[rel_error4,error4/total_iteration]; %Full gradient
 end
    
      save(fname_proposed,'rel_error2');
%                save(fname_phase,'rel_error3');
               save(fname_gradient,'rel_error4');
    
 

  plot(a_list,rel_error2,'Color','blue','DisplayName','Proposed','Linewidth',2)
  hold on
%   plot(a_list,rel_error3,'Color','red','DisplayName','Truncated','Linewidth',2)
%   hold on
  plot(a_list,rel_error4,'--','Color','black','DisplayName','GD','Linewidth',2)
  set(gca,'FontSize',30)


  
 ylabel('Relative Error','interpreter','LaTeX','FontSize', 35, 'FontName', 'Times New Roman')
 xlabel('\alpha','FontSize', 40, 'FontName', 'Times New Roman') 
 legend('FontName', 'Times New Roman','FontSize',25)

    