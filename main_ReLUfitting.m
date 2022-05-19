clear all;
clc;

rng(1);
K=100; %total number of iterations
d_list=[100,200,400,800]; %dimension
n_list=6*d_list;%# of samples
total_iteration=10; %Total iteration for fixed parameter, dimension, and the number of observations.
eta=0.8;% stepsize
al=1;
au=5;
error_1=[];
error_2=[];
error_3=[];

% w0=make_gtrthpar(d); % size d 

for j=1:length(d_list)
    d=d_list(j);
    n=n_list(j);
    loss_mat=[];
    for t=1:total_iteration
        w0=make_gtrthpar(d); % size d 
        w=[];
        X_sample=randn(n,d);  %sample size n x d
        y=ReLU(w0,X_sample); 
        w_tmp=Specinit(X_sample,y,al,au);
        if w_tmp'*w0<0
           w_tmp=-w_tmp; 
        end
        loss=[];
        for k=1:K
            w=[w  w_tmp];
            w_tmp=w_tmp-eta*ReLU_gradient(w0,w_tmp,n,X_sample);    %gradient descent step
            loss=[loss 1/(2*n)*sum((ReLU(w_tmp,X_sample)-ReLU(w0,X_sample)).^2)];
        end   
        loss_mat=[loss_mat; loss];
    end
    plot(1:K,1/total_iteration*sum(loss_mat))
    hold on
end