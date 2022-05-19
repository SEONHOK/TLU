clear all;
clc;

rng(1);
K=200; %total number of iterations
d_list=[100:50:600]; %dimension
n_list=100:100:5000;%# of samples
total_iteration=10; %Total iteration for fixed parameter, dimension, and the number of observations.
eta=0.8;% stepsize
al=1;
au=5;
error_1=[];
error_2=[];
error_3=[];

% w0=make_gtrthpar(d); % size d 
Normalized_error=[];
for j=1:length(d_list)
    d=d_list(j);
    for i=1:length(n_list)
        n=n_list(i);
        loss_mat=[];
        fname_DC = ['ReLU'  'd' num2str(d) 'n' num2str(n) '.mat'];
        Normalized_error=[];
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
            end   
            Normalized_error=[Normalized_error; 1/(2*n)*sum((ReLU(w_tmp,X_sample)-ReLU(w0,X_sample)).^2)];
        end
        save(fname_DC,'Normalized_error');
    end
    

end