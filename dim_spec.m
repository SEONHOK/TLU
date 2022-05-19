clear all;
clc;

rng(2);
K=50; %total number of iterations
% d_list=[50,100]; %dimension
% n=10*d_list;%# of samples
d_list=50:50:500;
sigma=0.1;
total_iteration=50; %Total iteration for fixed parameter, dimension, and the number of observations.
al=1;
au=5;
a=-1;
a_list=-1:0.1:1;
% stepsize
error_1=[];
error_2=[];
error_3=[];
rel_error1=[];
rel_error2=[];
rel_error3=[];
rel_error4=[];
rel_error5=[];
n_list=[10 15 20]*d;
    
for n=n_list
 
  fname_proposed = ['Proposed'  'sigma' num2str(sigma) 'n' num2str(n) '.mat'];      
  
for d=d_list    
 
 for i=1:length(a_list)
    

    a=a_list(i);
        eta=2/(1+a);    
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
    error2=error2+min(norm(w_tmp_0-w0)/norm(w0),norm(-w_tmp_0-w0)/norm(w0));
    end
    rel_error2=[rel_error2,error2/total_iteration];  %proposed method
 end
    rel_error3=[rel_error3 mean(rel_error2)];
end
 save(fname_proposed,'rel_error3');
end

CheckM=cell2mat(struct2cell(load('dimensionsigma0.1.mat')));
CheckM2=cell2mat(struct2cell(load('dimensionsigma0.1m15.mat')));
CheckM3=cell2mat(struct2cell(load('dimensionsigma0.1m20.mat')));

d_list=50:50:500;

plot(d_list,CheckM,'b--','LineWidth',2','DisplayName','n=10p')
hold on
plot(d_list,CheckM2,'r-o','LineWidth',2','DisplayName','n=15p')
hold on
plot(d_list,CheckM3,'black','LineWidth',2','DisplayName','n=20p')

 ylim([0,1])
 xlim([50,500])
 set(gca,'FontSize',30)

ylabel('Relative Error','interpreter','LaTeX','FontSize', 35, 'FontName', 'Times New Roman')
 xlabel('p','FontSize', 40, 'FontName', 'Times New Roman') 
 legend('FontName', 'Times New Roman','FontSize',25)


