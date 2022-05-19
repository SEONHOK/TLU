function w_init=Specinit(X_sample,y,al,au,alpha)
         Y_sum=0;
         [n,p]=size(X_sample);
          lambda_0=(1/(1-alpha))*2*n*p/sum(sum(abs(X_sample)))*1/n*(sum(y));
%          lambda_0=n*p/sum(sum(abs(X_sample)))*1/n*(sum(y));

         for i=1:n
               if al*lambda_0<y(i) && y(i)<au*lambda_0
                Y_sum=Y_sum+y(i)*X_sample(i,:)'*X_sample(i,:);
               end
               
         end
         Y=1/n*Y_sum;
         [V,D] = eig(Y);
         [~,index]=max(diag(D));
         w_tmp=V(:,index);
         w_init=lambda_0*w_tmp;
end
