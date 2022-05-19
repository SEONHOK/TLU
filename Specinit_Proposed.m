function [w_init,lambda_0]=Specinit_Proposed(X_sample,y,alpha)
         Y_sum=0;
         [n,p]=size(X_sample);
          lambda_0=min(abs(n*p/sum(sum(abs(X_sample)))*2/(1-alpha)*1/n*(sum(y))),2/(1+alpha)*norm(1/n*sum(y.*X_sample)));  
             for i=1:n 
                 Y_sum=Y_sum+(y(i))*(X_sample(i,:)'*X_sample(i,:));
             end
          Y=(1+alpha)/2*(1/n^2)*sum((y.*X_sample),1)'*sum((y.*X_sample),1)+(1-alpha)/2*1/n*Y_sum;

         [V,D] = eig(Y);
         [~,index]=max(diag(D));
         w_tmp=V(:,index);
         w_init=lambda_0*w_tmp;         
   
end

