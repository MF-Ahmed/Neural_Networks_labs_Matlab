function d1 = dist2( X, Y )
  d1=repmat(sum(X'.^2)',1,size(Y,1));
  d1=d1+repmat(sum(Y'.^2),size(X,1),1);
  d1=abs(d1-2*X*Y');
end