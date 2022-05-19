function grad=leakyReLU_gradient(y,w_tmp,n,X_sample,a)


         grad_tmp=(leakyReLU(w_tmp,X_sample,a)-y).*((1+a)+(1-a)*sign(X_sample*w_tmp));
         sum=0;
         for i=1:n
             sum=sum+grad_tmp(i)*X_sample(i,:)';
         end
         grad=1/n*sum;
end
