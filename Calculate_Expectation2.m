clear; clc

n=100000;
epsilon=0.01;
al=1;
au=5;
s1=0;
s2=0;
alpha=1;
for i=1:n
   g=normrnd(0,1); 
   v=(1-alpha)/2*abs(g)+(1+alpha)/2*g;
    if  (al*(1+epsilon)<v) && (v<au*(1-epsilon))
    s1=s1+v*g^2;
    s2=s2+v;
    end
end
output1=(1/n)*(s1-s2)
output2=(1/n)*(s2)