function [y]=leakyReLU(w,X,a)
    y=(abs(X*w-a*X*w)+X*w+a*X*w)/2;
end