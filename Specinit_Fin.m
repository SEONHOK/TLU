function [w_init2,lambda_0]=Specinit_Fin(X_sample,y,al,au,alpha)
         Y_sum=0;
         [n,~]=size(X_sample);
         lambda_0=(sqrt(2*pi)/(1-alpha))*1/n*(sum(y));

         for i=1:n
                if (abs(alpha)*al*lambda_0)<(y(i)) && (y(i))<au*lambda_0
                Y_sum=Y_sum+y(i)*X_sample(i,:)'*X_sample(i,:);
                end
         end
         Y=1/n*Y_sum;
         [V,D] = eig(Y);
         [~,index]=max(diag(D));
         w_tmp=V(:,index);
         w_init=lambda_0*w_tmp;
         w_init2=(1-alpha)/2*w_init+(1+alpha)*2/n*sum((y.*X_sample),1)';
end
