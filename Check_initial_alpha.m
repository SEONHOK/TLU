clear all;
clc;

rng(2);
K=100; %total number of iterations
% d_list=[50,100]; %dimension
% n=10*d_list;%# of samples
d=100;
n=20*d;
total_iteration=100; %Total iteration for fixed parameter, dimension, and the number of observations.

al=1;
au=5;
a=-1;
a_list=-1:0.1:1;

error_1=[];
error_2=[];
error_3=[];
 rel_error1=[];
    rel_error2=[];
    rel_error3=[];
    rel_error4=[];

% for i=1:length(d_list)
% d=d_list(i);
    for i=1:length(a_list)
    a=a_list(i);
    eta=2/(1+a);% stepsize
    w0=make_gtrthpar(d); % size d 
    w=[];
  
    zero_vector=zeros(size(w0));
    error1=0;
    error2=0;
    error3=0;
    error4=0;
    test=[];
    for t=1:total_iteration
    rng(t)
    X_sample=randn(n,d);  %sample size n x d
%     y=abs(X_sample*w0);
    y_1=ReLU(w0,X_sample); 
    y=leakyReLU(w0,X_sample,a); 
     [w_tmp,lambda]=Specinit_Fin3(X_sample,y,al,au,a,w0); % ghosh's method
      test=[test lambda-norm(w0)];
         
    w_tmp_0=Specinit_Fin5(X_sample,y,al,au,a);  % Proposed Method
      [w_tmp_1,lambda1]=Specinit_Fin(X_sample,y,al,au,a); % Previous proposed method
     error1=error1+min(norm(w_tmp-w0)/norm(w0),norm(-w_tmp-w0)/norm(w0));
    error2=error2+min(norm(w_tmp_0-w0)/norm(w0),norm(-w_tmp_0-w0)/norm(w0));
     error3=error3+min(norm(w_tmp_1-w0)/norm(w0),norm(-w_tmp_1-w0)/norm(w0));

%     w_tmp2=zero_vector-eta*ReLU_gradient(w0,zero_vector,n(i),X_sample);
    w_tmp2=zero_vector-eta*leakyReLU_gradient(w0,zero_vector,n,X_sample,a); %Full gradient

    error4=error4+norm(w_tmp2-w0)/norm(w0);
    end
    median(test)
     rel_error1=[rel_error1,error1/total_iteration] %Ghosh's method
    rel_error2=[rel_error2,error2/total_iteration]  %proposed method
     rel_error3=[rel_error3,error3/total_iteration] %previous proposed method
    rel_error4=[rel_error4,error4/total_iteration]  %Full gradient
    end
% end
  plot(a_list,rel_error1,'red')
    hold on
    plot(a_list,rel_error2,'blue')
      hold on
     plot(a_list,rel_error3,'green')
         hold on
    plot(a_list,rel_error4,'black')