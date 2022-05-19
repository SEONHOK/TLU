clear all;
clc;

rng(1);
K=100; %total number of iterations
sigma_list=[0.1 0.2 0.3  0.4 0.5];
d=50; %dimension
% n=10*d;%# of samples
n_list=(1:20)*2*d;
total_iteration=50; %Total iteration for fixed parameter, dimension, and the number of observations.
eta=0.5;% stepsize
alpha_list=-1:0.1:1;
al=1;
au=5;
error_1=[];
error_2=[];
error_3=[];

% w0=make_gtrthpar(d); % size d 


for sigma=sigma_list
 
     fname_proposed = ['consistency' num2str(sigma) 'd' num2str(d) '.mat'];      

  
 
for n=n_list
 
   for a=alpha_list
          error_mat=[];
        for t=1:total_iteration
            w0=make_gtrthpar(d); % size d 
            w=[];
            X_sample=randn(n,d);  %sample size n x d
            y=leakyReLU(w0,X_sample,a)+sigma*randn(size(leakyReLU(w0,X_sample,a))); 
            w_tmp=Specinit_Proposed(X_sample,y,a);
            if w_tmp'*w0<0
               w_tmp=-w_tmp; 
            end
            loss=[];
            error_1=[];
            for k=1:K
                w_tmp=w_tmp-eta*leakyReLU_gradient(y,w_tmp,n,X_sample,a);    %gradient descent step
            end   
            error_mat=[error_mat; (norm(w_tmp-w0)/norm(w0))];
        end
         error_2=[error_2; mean(error_mat)];
   end
   error_3=[error_3; mean(error_2)];
end
save(fname_proposed,'error_3');
end

CheckM=cell2mat(struct2cell(load('consistency0.1d50.mat')));
CheckM2=cell2mat(struct2cell(load('consistency0.2d50.mat')));
CheckM3=cell2mat(struct2cell(load('consistency0.3d50.mat')));

n_list=(1:20)*2*d;
semilogy(n_list,CheckM,'r-.','DisplayName','\sigma=0.1','LineWidth',3')
hold on  
semilogy(n_list,CheckM2,'black','DisplayName','\sigma=0.2','LineWidth',3')
hold on
semilogy(n_list,CheckM3,'b--','DisplayName','\sigma=0.3','LineWidth',3')

    
    
 xlim([200,2000])
     set(gca,'FontSize',30)

     
 ylabel('Relative Error','interpreter','LaTeX','FontSize', 35, 'FontName', 'Times New Roman')
 xlabel('n','FontSize', 40, 'FontName', 'Times New Roman') 
 legend('FontName', 'Times New Roman','FontSize',25)
    