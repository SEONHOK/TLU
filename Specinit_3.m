function w_init=Specinit_3(X_sample,y,al,au,alpha)
         Y_sum=0;
         [n,~]=size(X_sample);
          lambda_0=1/(1+abs(alpha))*sqrt(2*pi)*1/n*(sum(abs(y)));
%          lambda_0=n*p/sum(sum(abs(X_sample)))*1/n*(sum(y));

         for i=1:n
               if  (abs(alpha)*al*lambda_0)<abs(y(i)) 
                Y_sum=Y_sum+abs(y(i))*X_sample(i,:)'*X_sample(i,:);
               end
               
         end
         Y=1/n*Y_sum;
         [V,D] = eig(Y);
         [~,index]=max(diag(D));
         w_tmp=V(:,index);
         w_init=lambda_0*w_tmp;
end
