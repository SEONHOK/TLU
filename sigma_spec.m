clear all;
clc;

rng(2);
K=50; %total number of iterations
% d_list=[50,100]; %dimension
% n=10*d_list;%# of samples
d=50;
sigma_list=0.1:0.1:2;
total_iteration=1; %Total iteration for fixed parameter, dimension, and the number of observations.
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
n_list=[10 15 20]*d;
    
  
for n=n_list
   
    fname_proposed = ['Proposedsigma','n', num2str(n).mat'];    

for sigma=sigma_list    
  

 for i=1:length(a_list)
    
    eta=2/(1+a);    
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
        y_1=ReLU(w0,X_sample); 
        rng(t);
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
 

CheckM=cell2mat(struct2cell(load('Proposedsigma.mat')));
CheckM2=cell2mat(struct2cell(load('Proposedsigman750.mat')));
CheckM3=cell2mat(struct2cell(load('Proposedsigman1000.mat')));

sigma_list=0:0.05:1
plot(sigma_list,CheckM,'r-o','DisplayName','n=10p','LineWidth',2')
hold on
plot(sigma_list,CheckM2,'b-^','DisplayName','n=15p','LineWidth',2')
hold on
plot(sigma_list,CheckM3,'black--','DisplayName','n=20p','LineWidth',2')

set(gca,'FontSize',30)


 ylim([0,1])
ylabel('Relative Error','interpreter','LaTeX','FontSize', 35, 'FontName', 'Times New Roman')
 xlabel('\sigma','FontSize', 40, 'FontName', 'Times New Roman') 
 legend('FontName', 'Times New Roman','FontSize',25)

